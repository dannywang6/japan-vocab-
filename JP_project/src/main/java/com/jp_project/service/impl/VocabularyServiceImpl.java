package com.jp_project.service.impl;


import com.jp_project.dto.AnalyzeResultDTO;
import com.jp_project.dto.PageResult;
import com.jp_project.entity.Vocabulary;
import com.jp_project.mapper.StudyRecordMapper;
import com.jp_project.mapper.VocabularyMapper;
import com.jp_project.service.AIService;
import com.jp_project.service.BaiduTranslateService;
import com.jp_project.service.JishoService;
import com.jp_project.service.ReviewService;
import com.jp_project.service.VocabularyService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
@RequiredArgsConstructor
public class VocabularyServiceImpl implements VocabularyService {

    private final VocabularyMapper vocabularyMapper;

    // 加词同时进入复习计划
    private final ReviewService reviewService;

    // Jisho 词典查询（保留，暂不调用）
    private final JishoService jishoService;

    // 百度翻译（保留，暂不调用）
    private final BaiduTranslateService baiduTranslateService;

    // AI 服务（智谱 GLM-4-Flash）
    private final AIService aiService;
    private final StudyRecordMapper studyRecordMapper;


    @Override
    public List<Vocabulary> listAll() {
        return vocabularyMapper.selectAll();
    }

    @Override
    public void addVocabulary(Vocabulary vocabulary) {
        LocalDateTime now = LocalDateTime.now();

        vocabulary.setCreatedAt(now);
        vocabulary.setUpdatedAt(now);

        if (vocabulary.getImportant() == null) {
            vocabulary.setImportant(0);
        }
        vocabularyMapper.insert(vocabulary);
        reviewService.startReview(vocabulary.getId());
    }

    @Override
    public Vocabulary getById(Long id) {
        Vocabulary vocabulary = vocabularyMapper.selectById(id);
        if (vocabulary == null) {
            throw new RuntimeException("词汇不存在");
        }
        return vocabulary;
    }

    @Override
    public void updateVocabulary(Vocabulary vocabulary) {
        vocabulary.setUpdatedAt(LocalDateTime.now());

        int rows = vocabularyMapper.update(vocabulary);
        if (rows == 0) {
            throw new RuntimeException("词汇不存在");
        }
    }

    @Override
    public void deleteVocabulary(Long id) {
        // 先删除学习记录
        studyRecordMapper.deleteByVocabId(id);
        // 再删除词汇
        int rows = vocabularyMapper.deleteById(id);
        if (rows == 0) {
            throw new RuntimeException("词汇不存在");
        }
    }

    /**
     * 自动填充：调用 AI 解析单词
     * AI 一次性返回 kanji/kana/romaji/meaning/english
     */
    @Override
    public AnalyzeResultDTO analyzeWord(String word) {
        AnalyzeResultDTO result = aiService.analyzeWord(word);

        // 查重
        if (result.getKana() != null && !result.getKana().isEmpty()) {
            Vocabulary existing = vocabularyMapper.selectByKana(result.getKana());
            if (existing != null) {
                result.setDuplicate(true);
                result.setMessage("该词已存在（假名：" + existing.getKana() + "）");
            }
        }
        if (!result.isDuplicate() && result.getKanji() != null && !result.getKanji().isEmpty()) {
            Vocabulary existing = vocabularyMapper.selectByKanji(result.getKanji());
            if (existing != null) {
                result.setDuplicate(true);
                result.setMessage("该词已存在（汉字：" + existing.getKanji() + "）");
            }
        }

        return result;
    }

    @Override
    public List<Vocabulary> search(String keyword) {
        return vocabularyMapper.search(keyword);
    }

    @Override
    public PageResult<Vocabulary> page(String keyword, int page, int size) {
        if (page < 1) page = 1;
        if (size < 1) size = 20;
        if (size > 200) size = 200;
        int offset = (page - 1) * size;
        long total = vocabularyMapper.count(keyword);
        List<Vocabulary> list = vocabularyMapper.selectPage(keyword, offset, size);
        return new PageResult<>(total, list);
    }
}
