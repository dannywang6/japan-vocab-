package com.jp_project.service.impl;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.jp_project.dto.JishoResultDTO;
import com.jp_project.service.JishoService;
import org.springframework.stereotype.Service;
import com.jp_project.dto.JishoResultDTO;

import java.net.URI;
import java.net.URLEncoder;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.nio.charset.StandardCharsets;

/**
 * Jisho API 实现
 * 文档：https://jisho.org/api/v1/search/words
 */
@Service
public class JishoServiceImpl implements JishoService {

    // Jisho API 地址
    private static final String API_URL = "https://jisho.org/api/v1/search/words?keyword=";

    // Jackson JSON 解析器
    private static final ObjectMapper MAPPER = new ObjectMapper();

    // HTTP 客户端
    private final HttpClient httpClient = HttpClient.newHttpClient();

    /**
     * 查询单词
     * 取返回结果的 data[0]，提取汉字、假名、英文
     */
    @Override
    public JishoResultDTO search(String keyword) {
        try {
            // 拼接 URL（keyword 需要 URL 编码）
            String url = API_URL + URLEncoder.encode(keyword, StandardCharsets.UTF_8);

            // 发 GET 请求
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create(url))
                    .GET()
                    .build();

            HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());

            // 解析 JSON
            JsonNode root = MAPPER.readTree(response.body());
            JsonNode data = root.path("data");

            // 没有结果
            if (!data.isArray() || data.isEmpty()) {
                return null;
            }

            // 取第一条
            JsonNode first = data.get(0);

            JishoResultDTO result = new JishoResultDTO();

            // 提取日汉字和假名
            JsonNode japanese = first.path("japanese");
            if (japanese.isArray() && !japanese.isEmpty()) {
                JsonNode ja0 = japanese.get(0);
                // word 字段可能不存在（纯假名词没有 word）
                if (ja0.has("word")) {
                    result.setKanji(ja0.get("word").asText());
                }
                result.setKana(ja0.get("reading").asText());
            }

            // 提取英文释义（取第一个义项的第一个定义）
            JsonNode senses = first.path("senses");
            if (senses.isArray() && !senses.isEmpty()) {
                JsonNode engDefs = senses.get(0).path("english_definitions");
                if (engDefs.isArray() && !engDefs.isEmpty()) {
                    result.setEnglish(engDefs.get(0).asText());
                }
            }

            return result;

        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}