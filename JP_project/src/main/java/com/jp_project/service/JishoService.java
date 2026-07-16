package com.jp_project.service;

import com.jp_project.dto.JishoResultDTO;

/**
 * Jisho API 接口（日语词典查询）
 */
public interface JishoService {

    /**
     * 查询单词
     * @param keyword 日文或英文
     * @return 查询结果，没找到返回 null
     */
    JishoResultDTO search(String keyword);
}
