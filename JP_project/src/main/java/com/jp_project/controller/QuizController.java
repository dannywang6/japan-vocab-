package com.jp_project.controller;

import com.jp_project.common.ApiResponse;
import com.jp_project.dto.QuizQuestionDTO;
import com.jp_project.dto.QuizResultDTO;
import com.jp_project.dto.QuizSubmitDTO;
import com.jp_project.service.QuizService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/quiz")
@RequiredArgsConstructor
public class QuizController {

    private final QuizService quizService;

    // 获取一道题
    // type 传 cn_to_jp 或 jp_to_cn
    @GetMapping("/question")
    public ApiResponse<QuizQuestionDTO> getQuestion(
            @RequestParam(defaultValue = "jp_to_cn") String type) {
        return ApiResponse.success(quizService.generateQuestion(type));
    }

    // 提交答案
    @PostMapping("/submit")
    public ApiResponse<QuizResultDTO> submitAnswer(@Valid @RequestBody QuizSubmitDTO submitDTO) {
        return ApiResponse.success(quizService.submitAnswer(submitDTO));
    }

    // 确认出错
    @PostMapping("/confirm-mistakes")
    public ApiResponse<Void> confirmMistakes(@RequestBody List<Long> vocabIds) {
        quizService.confirmMistakes(vocabIds);
        return ApiResponse.success(null);
    }
}