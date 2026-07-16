package com.jp_project.service;


import com.jp_project.dto.AnalyzeResultDTO;
import com.jp_project.entity.Vocabulary;

import java.util.List;

public interface VocabularyService {
    List<Vocabulary> listAll();

    void addVocabulary(Vocabulary vocabulary);

    Vocabulary getById (Long id);

    void updateVocabulary(Vocabulary vocabulary);

    void deleteVocabulary(Long id);

    /** 自动填充：解析单词，返回假名、汉字、罗马字、中文、英文 */
    AnalyzeResultDTO analyzeWord(String word);

    // 全局搜索
    List<Vocabulary> search(String keyword);
}
