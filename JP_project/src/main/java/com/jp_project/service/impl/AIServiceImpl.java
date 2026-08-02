package com.jp_project.service.impl;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.jp_project.dto.AnalyzeResultDTO;
import com.jp_project.service.AIService;
import com.jp_project.util.JapaneseUtil;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.nio.charset.StandardCharsets;
import java.time.Duration;
import java.util.*;

/**
 * 阿里 Qwen AI 实现
 * API 文档：https://help.aliyun.com/zh/model-studio/developer-reference/use-qwen-by-calling-api
 */
@Service
public class AIServiceImpl implements AIService {

    @Value("${ai.api-key}")
    private String apiKey;

    @Value("${ai.model}")
    private String model;

    private static final String API_URL = "https://dashscope.aliyuncs.com/compatible-mode/v1/chat/completions";

    private static final ObjectMapper MAPPER = new ObjectMapper();

    /**
     * 解析单词：让 AI 返回 kanji/kana/romaji/meaning/english
     */
    @Override
    public AnalyzeResultDTO analyzeWord(String word) {
        AnalyzeResultDTO result = new AnalyzeResultDTO();

        String systemPrompt = "你是一个日语词典API。用户给你一个词（可能是日文、中文或英文），"
                + "你必须返回现代日本日常生活中最口语化、最常用的那个对应词。"
                + "规则：\n"
                + "1. 有多个同义词时，选日本人日常对话中最常说的那个，不要选书面语或正式用语\n"
                + "2. 通常用假名写的词，kanji返回空字符串\n"
                + "3. 片假名外来语通常没有汉字写法，kanji返回空字符串\n"
                + "4. 只返回JSON，不要任何解释\n"
                + "示例：\n"
                + "输入'飞机场'→{\"kanji\":\"空港\",\"kana\":\"くうこう\",\"meaning\":\"机场\",\"english\":\"airport\"}\n"
                + "输入'手机'→{\"kanji\":\"\",\"kana\":\"スマホ\",\"meaning\":\"手机\",\"english\":\"smartphone\"}";

        String userPrompt = "词：" + word + "\n"
                + "返回格式：{\"kanji\":\"汉字写法或空字符串\",\"kana\":\"平假名或片假名\",\"meaning\":\"中文\",\"english\":\"英文\"}";

        try {
            String aiResponse = callQwen(systemPrompt, userPrompt);
            if (aiResponse == null) {
                result.setMessage("AI 返回为空");
                return result;
            }

            String json = extractJson(aiResponse);

            JsonNode node = MAPPER.readTree(json);
            result.setKanji(node.has("kanji") ? node.get("kanji").asText() : "");
            result.setKana(node.has("kana") ? node.get("kana").asText() : "");
            result.setMeaning(node.has("meaning") ? node.get("meaning").asText() : "");
            result.setEnglish(node.has("english") ? node.get("english").asText() : "");

            // 罗马字用我们自己的转换，不依赖 AI
            String kana = result.getKana();
            if (kana != null && !kana.isEmpty()) {
                // 先转片假名为平假名，再转罗马字
                String hiragana = JapaneseUtil.katakanaToHiragana(kana);
                String romaji = JapaneseUtil.hiraganaToRomaji(hiragana);
                result.setRomaji(romaji);
            }

            return result;

        } catch (Exception e) {
            e.printStackTrace();
            result.setMessage("AI 解析失败: " + e.getMessage());
            return result;
        }
    }

    /**
     * 调用阿里 Qwen API（OpenAI 兼容格式）
     */
    private String callQwen(String systemPrompt, String userPrompt) throws Exception {
        Map<String, Object> body = new HashMap<>();
        body.put("model", model);
        body.put("temperature", 0.1);

        List<Map<String, String>> messages = new ArrayList<>();

        Map<String, String> sysMsg = new HashMap<>();
        sysMsg.put("role", "system");
        sysMsg.put("content", systemPrompt);
        messages.add(sysMsg);

        Map<String, String> userMsg = new HashMap<>();
        userMsg.put("role", "user");
        userMsg.put("content", userPrompt);
        messages.add(userMsg);

        body.put("messages", messages);

        String jsonBody = MAPPER.writeValueAsString(body);

        var httpClient = HttpClient.newBuilder()
                .connectTimeout(Duration.ofSeconds(10))
                .build();

        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(API_URL))
                .header("Content-Type", "application/json")
                .header("Authorization", "Bearer " + apiKey)
                .timeout(Duration.ofSeconds(30))
                .POST(HttpRequest.BodyPublishers.ofString(jsonBody, StandardCharsets.UTF_8))
                .build();

        HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());

        System.out.println("AI响应: " + response.body());

        JsonNode root = MAPPER.readTree(response.body());

        if (root.has("error")) {
            System.err.println("AI错误: " + root.get("error").toString());
            return null;
        }

        JsonNode choices = root.path("choices");
        if (choices.isArray() && !choices.isEmpty()) {
            return choices.get(0).path("message").path("content").asText();
        }

        return null;
    }

    /**
     * 从 AI 返回中提取 JSON（去掉可能的 markdown 代码块标记）
     */
    private String extractJson(String text) {
        if (text == null) return "{}";
        text = text.replaceAll("```json\\s*", "").replaceAll("```\\s*", "");
        return text.trim();
    }
}