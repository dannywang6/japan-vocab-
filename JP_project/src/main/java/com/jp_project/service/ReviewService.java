package com.jp_project.service;

import com.jp_project.dto.QuizQuestionDTO;
import com.jp_project.dto.QuizResultDTO;
import com.jp_project.dto.TodayReviewDTO;

public interface ReviewService {

    // 今日待复习概览
    TodayReviewDTO getTodayReview();

    // 新词加入复习计划
    void startReview(Long vocabId);

    // 完成一次复习，更新stage
    void completeReview(Long vocabId, Boolean isCorrect);

    //复习出题
    QuizQuestionDTO generateReviewQuestion();
}