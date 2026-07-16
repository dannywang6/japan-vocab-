package com.jp_project.service.impl;

import com.jp_project.dto.QuizQuestionDTO;
import com.jp_project.dto.QuizResultDTO;
import com.jp_project.dto.QuizSubmitDTO;
import com.jp_project.entity.QuizRecord;
import com.jp_project.entity.StudyRecord;
import com.jp_project.entity.Vocabulary;
import com.jp_project.mapper.QuizMapper;
import com.jp_project.mapper.QuizRecordMapper;
import com.jp_project.mapper.StudyRecordMapper;
import com.jp_project.mapper.VocabularyMapper;
import com.jp_project.service.QuizService;
import com.jp_project.service.VocabularyService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Random;

@Service
@RequiredArgsConstructor
public class QuizServiceImpl implements QuizService {

    private final QuizMapper quizMapper;
    private final QuizRecordMapper quizRecordMapper;
    private final VocabularyMapper vocabularyMapper;
    private final StudyRecordMapper studyRecordMapper;

    @Override
    public QuizQuestionDTO generateQuestion(String quizType) {
        // 拿到所有词 + 所有至少答错过1词的词ID
        List<Vocabulary> all = vocabularyMapper.selectAll();
        List<Long> wrongVocabIds = quizRecordMapper.selectAllWrongVocabIds();

        // 分三个桶:错的最多,重点,普通
        List<Vocabulary> wrongBucket = new ArrayList<>();
        List<Vocabulary> importantBucket = new ArrayList<>();
        List<Vocabulary> normalBucket = new ArrayList<>();

        for (Vocabulary v : all) {
            if (wrongVocabIds.contains(v.getId())) {
                wrongBucket.add(v);
            } else if (v.getImportant() != null && v.getImportant() == 1) {
                importantBucket.add(v);
            } else {
                normalBucket.add(v);
            }
        }

        // 按权重 选正确答案
        Vocabulary correct = pickByWeight(wrongBucket, importantBucket, normalBucket);
        if (correct == null) {
            correct = all.get(new Random().nextInt(all.size()));
        }

        // 收集正确答案id
        List<Long> excludeIds = new ArrayList<>();
        excludeIds.add(correct.getId());

        // 优先从最近答错的词中选取干扰项 3个
        List<Long> recentWrongIds = quizRecordMapper.selectRecentWrongVocabIds(10);
        recentWrongIds.removeAll(excludeIds);

        List<Vocabulary> distractors = new ArrayList<>();
        for (Long wrongId : recentWrongIds) {
            if (distractors.size() >= 3) break;
            Vocabulary v = vocabularyMapper.selectById(wrongId);
            if (v != null) {
                distractors.add(v);
                excludeIds.add(wrongId);
            }
        }
        // 不够3个干扰项的 从全量中取
        while (distractors.size() < 3) {
            Vocabulary v = quizMapper.selectRandomExcludeIds(excludeIds);
            if (v != null) {
                distractors.add(v);
                excludeIds.add(v.getId());
            } else {
                break;
            }
        }

        // 组装成四个选项 并且打乱顺序
        List<Vocabulary> allOptions = new ArrayList<>();
        allOptions.add(correct);
        allOptions.addAll(distractors);
        Collections.shuffle(allOptions);

        //根据题型决定题干以及选项
        QuizQuestionDTO dto = new QuizQuestionDTO();
        dto.setQuizType(quizType);
        dto.setCorrectVocabId(correct.getId());

        if ("cn_to_jp".equals(quizType)) {
            dto.setCorrectMeaning(correct.getMeaning());
            dto.setOptions(allOptions.stream().map(v -> {
                QuizQuestionDTO.OptionDTO opt = new QuizQuestionDTO.OptionDTO();
                opt.setVocabId(v.getId());
                opt.setKana(v.getKana());
                opt.setKanji(v.getKanji());
                opt.setRomaji(v.getRomaji());
                return opt;
            }).toList());
        } else {
            //jp_to_cn
            dto.setCorrectKana(correct.getKana());
            dto.setCorrectKanji(correct.getKanji());
            dto.setCorrectRomaji(correct.getRomaji());
            dto.setOptions(allOptions.stream().map(v -> {
                QuizQuestionDTO.OptionDTO opt = new QuizQuestionDTO.OptionDTO();
                opt.setVocabId(v.getId());
                opt.setMeaning(v.getMeaning());
                return opt;
            }).toList());
        }
        return dto;
    }

    private Vocabulary pickByWeight(List<Vocabulary> wrongBucket,
                                    List<Vocabulary> importantBucket,
                                    List<Vocabulary> normalBucket) {
        Random rand = new Random();
        int roll = rand.nextInt(100);
        if (roll < 50 && !wrongBucket.isEmpty()) {
            return wrongBucket.get(rand.nextInt(wrongBucket.size()));
        } else if (roll < 80 && !importantBucket.isEmpty()) {
            return importantBucket.get(rand.nextInt(importantBucket.size()));
        } else if (!normalBucket.isEmpty()) {
            return normalBucket.get(rand.nextInt(normalBucket.size()));
        }
        return null;
    }
    @Override
    public QuizResultDTO submitAnswer(QuizSubmitDTO submitDTO) {
        boolean correct = submitDTO.getCorrectVocabId()
                .equals(submitDTO.getSelectedVocabId());

        // 记录答题结果
        QuizRecord record = new QuizRecord();
        record.setVocabId(submitDTO.getCorrectVocabId());
        record.setQuizType(submitDTO.getQuizType());
        record.setIsCorrect(correct);
        quizRecordMapper.insert(record);

        // 查四个选项完整信息（前端传过来的selectedVocabId + correctVocabId，
        // 但我们需要四个选项，所以前端提交时带上全部四个选项的id）
        List<Vocabulary> allOptions = quizMapper.selectByIds(submitDTO.getAllOptionIds());

        QuizResultDTO result = new QuizResultDTO();
        result.setCorrect(correct);
        result.setCorrectVocabId(submitDTO.getCorrectVocabId());
        result.setSelectedVocabId(submitDTO.getSelectedVocabId());
        result.setAllOptions(allOptions);
        return result;
    }

    //确定错误 然后存回数据库
    @Override
    public void confirmMistakes(List<Long> vocabIds) {
        for (Long id : vocabIds) {
            StudyRecord record = studyRecordMapper.selectByVocabId(id);
            if (record != null) {
                record.setReviewStage(0);
                record.setNextReviewAt(LocalDate.now().plusDays(1));
                record.setLastReviewedAt(LocalDateTime.now());
                studyRecordMapper.update(record);
            } else {
                StudyRecord newRecord = new StudyRecord();
                newRecord.setVocabId(id);
                newRecord.setReviewStage(0);
                newRecord.setNextReviewAt(LocalDate.now().plusDays(1));
                studyRecordMapper.insert(newRecord);
            }
        }
    }

}