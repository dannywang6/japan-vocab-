package com.jp_project.controller;

import com.jp_project.common.ApiResponse;
import com.jp_project.dto.KanaSessionDTO;
import com.jp_project.service.KanaAnswerLogService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/kana/answer-logs")
@RequiredArgsConstructor
public class KanaAnswerLogController {

    private final KanaAnswerLogService kanaAnswerLogService;

    //提交整场成绩
    @PostMapping("/session")
    public ApiResponse<Void> submitSession(@Valid @RequestBody KanaSessionDTO dto) {
        kanaAnswerLogService.submitSession(dto);
        return ApiResponse.success(null);
    }

    //封存记录
    @PostMapping("/archive")
    public ApiResponse<Void> archiveAll() {
        kanaAnswerLogService.archiveAll();
        return ApiResponse.success(null);
    }
}
