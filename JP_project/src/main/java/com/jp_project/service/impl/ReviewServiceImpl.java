package com.jp_project.service.impl;

import com.jp_project.dto.QuizQuestionDTO;
import com.jp_project.dto.TodayReviewDTO;
import com.jp_project.entity.StudyRecord;
import com.jp_project.entity.Vocabulary;
import com.jp_project.mapper.StudyRecordMapper;
import com.jp_project.mapper.VocabularyMapper;
import com.jp_project.service.ReviewService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.Collections;
import java.util.Random;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
public class ReviewServiceImpl implements ReviewService {

    private final StudyRecordMapper studyRecordMapper;
    private final VocabularyMapper vocabularyMapper;


    //当前需要复习的单词
    @Override
    public TodayReviewDTO getTodayReview() {
        List<StudyRecord> records = studyRecordMapper.selectByNextReviewDate(LocalDate.now());

        List<Vocabulary> vocabList = records.stream()
                .map(r -> vocabularyMapper.selectById(r.getVocabId()))
                .filter(v -> v != null)
                .toList();

        TodayReviewDTO dto = new TodayReviewDTO();
        dto.setTotalCount(vocabList.size());
        dto.setVocabList(vocabList);
        return dto;
    }

    //新添加词汇到计划
    @Override
    public void startReview(Long vocabId) {
        // 已在计划里就不重复添加
        if (studyRecordMapper.existsByVocabId(vocabId)) {
            return;
        }
        StudyRecord record = new StudyRecord();
        record.setVocabId(vocabId);
        record.setReviewStage(0);
        // 新词第一次复习安排在明天
        record.setNextReviewAt(LocalDate.now().plusDays(1));
        studyRecordMapper.insert(record);
    }

    @Override
    public void completeReview(Long vocabId, Boolean isCorrect) {
        StudyRecord record = studyRecordMapper.selectByVocabId(vocabId);
        if (record == null) return;

        if (isCorrect) {
            // 答对：进入下一阶段
            int nextStage = Math.min(record.getReviewStage() + 1, 5);
            record.setReviewStage(nextStage);
            int interval = 1 << nextStage;
            record.setNextReviewAt(LocalDate.now().plusDays(interval));
        } else {
            // 答错：退回上阶段
            int nextStage = Math.max(record.getReviewStage() - 1,0);
            record.setReviewStage(nextStage);
            int interval = 1 << nextStage;
            record.setNextReviewAt(LocalDate.now().plusDays(interval));
        }

        record.setLastReviewedAt(LocalDateTime.now());
        studyRecordMapper.update(record);
    }

    @Override
    public QuizQuestionDTO generateReviewQuestion() {
        // 查今天待复习列表
        List<StudyRecord> records = studyRecordMapper.selectByNextReviewDate(LocalDate.now());
        
        // 过滤掉词汇已被删除的记录
        List<StudyRecord> validRecords = records.stream()
                .filter(r -> vocabularyMapper.selectById(r.getVocabId()) != null)
                .toList();
        
        if (validRecords.isEmpty()) return null;

        //随机取一个当正确答案
        Random rand = new Random();
        StudyRecord record = validRecords.get(rand.nextInt(validRecords.size()));
        Vocabulary correct = vocabularyMapper.selectById(record.getVocabId());

        // 随机取3个干扰项
        List<Vocabulary> all = vocabularyMapper.selectAll();
        List<Long> excludeIds = new ArrayList<>();
        excludeIds.add(correct.getId());

        List<Vocabulary> distractors = new ArrayList<>();
        while (distractors.size() < 3) {
            Vocabulary v = all.get(rand.nextInt(all.size()));
            if (!excludeIds.contains(v.getId())) {
                distractors.add(v);
                excludeIds.add(v.getId());
            }
        }

        List<Vocabulary> allOptions = new ArrayList<>();
        allOptions.add(correct);
        allOptions.addAll(distractors);
        Collections.shuffle(allOptions);
        // 组装 DTO
        QuizQuestionDTO dto = new QuizQuestionDTO();
        dto.setQuizType("review");
        dto.setCorrectVocabId(correct.getId());
        dto.setCorrectKana(correct.getKana());
        dto.setCorrectKanji(correct.getKanji());
        dto.setCorrectRomaji(correct.getRomaji());

        dto.setOptions(allOptions.stream().map(v -> {
            QuizQuestionDTO.OptionDTO opt = new QuizQuestionDTO.OptionDTO();
            opt.setVocabId(v.getId());

            opt.setMeaning(v.getMeaning());
            return opt;
        }).toList());
        return dto;
    }
}