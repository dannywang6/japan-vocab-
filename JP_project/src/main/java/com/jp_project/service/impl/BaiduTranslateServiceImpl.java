package com.jp_project.service.impl;


import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.jp_project.service.BaiduTranslateService;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.Map;

@Service
public class BaiduTranslateServiceImpl implements BaiduTranslateService {

    @Value("${baidu.translate.appid}")
    private String appid;

    @Value("${baidu.translate.api-key}")
    private String apikey;

    private static final String API_URL = "https://fanyi-api.baidu.com/ait/api/aiTextTranslate";

    private static final ObjectMapper MAPPER = new ObjectMapper();

    private final HttpClient httpClient = HttpClient.newHttpClient();


    @Override
    public String translate(String query, String from, String to) {
        try {
            // 构建 json
            Map<String, String> body = new HashMap<>();
            body.put("appid" ,appid);
            body.put("q", query);
            body.put("from", from);
            body.put("to", to);
            body.put("model_type", "llm");
            String jsonBody = MAPPER.writeValueAsString(body);

            // 发 post 请求 Bearer Token 鉴权
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create(API_URL))
                    .header("Content-type", "application/json")
                    .header("Authorization", "Bearer" + apikey)
                    .POST(HttpRequest.BodyPublishers.ofString(jsonBody, StandardCharsets.UTF_8))
                    .build();

            HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());
            System.out.println(response.body());

            // 解析json
            JsonNode root = MAPPER.readTree(response.body());
            //打印出来看看

            // 检查
            if (root.has("error_code")) {
                System.err.println("百度翻译错误: "
                + root.get("error_code").asText()
                + " " + root.get("error_msg").asText());

                return query;
            }

            // 取第一条翻译结果
            JsonNode transResult = root.path("trans_result");
            if (transResult.isArray() && !transResult.isEmpty()) {
                return transResult.get(0).get("dst").asText();
            }

            return query;
        } catch (Exception e) {
            e.printStackTrace();
            return query;
        }
    }

    @Override
    public String enToZh(String text) {
        return translate(text, "en", "zh");
    }

    @Override
    public String enToJp(String text) {
        return translate(text, "en", "jp");
    }

    @Override
    public String zhToJp(String text) {
        return translate(text, "zh", "jp");
    }
    @Override
    public String jpToZh(String text) {
        return translate(text, "jp", "zh");
    }

}