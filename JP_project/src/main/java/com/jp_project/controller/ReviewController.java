package com.jp_project.controller;

import com.jp_project.common.ApiResponse;
import com.jp_project.dto.QuizQuestionDTO;
import com.jp_project.dto.TodayReviewDTO;
import com.jp_project.service.ReviewService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/review")
@RequiredArgsConstructor
public class ReviewController {

    private final ReviewService reviewService;

    // 今日待复习概览
    @GetMapping("/today")
    public ApiResponse<TodayReviewDTO> getTodayReview() {

        return ApiResponse.success(reviewService.getTodayReview());
    }

    // 新词加入复习计划
    @PostMapping("/start/{vocabId}")
    public ApiResponse<Void> startReview(@PathVariable Long vocabId) {
        reviewService.startReview(vocabId);
        return ApiResponse.success(null);
    }

    // 完成一次复习
    @PostMapping("/complete")
    public ApiResponse<Void> completeReview(
            @RequestParam Long vocabId,
            @RequestParam Boolean isCorrect) {
        reviewService.completeReview(vocabId, isCorrect);
        return ApiResponse.success(null);
    }

    // 获取一道复习题
    @GetMapping("/question")
    public ApiResponse<QuizQuestionDTO> getReviewQuestion() {
        return ApiResponse.success(reviewService.generateReviewQuestion());
    }
}