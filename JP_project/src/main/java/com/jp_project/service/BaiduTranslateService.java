package com.jp_project.service;


/**
 * 百度翻译 API 接口
 */
public interface BaiduTranslateService {
    String translate(String query, String from, String to);

    String enToZh(String text);

    String enToJp(String text);

    String zhToJp(String text);

    String jpToZh(String text);
}
