package com.jp_project.controller;

import com.jp_project.common.ApiResponse;
import com.jp_project.dto.KanaHistoryRangeDTO;
import com.jp_project.dto.KanaSessionDTO;
import com.jp_project.dto.WeakKanaDTO;
import com.jp_project.service.KanaAnswerLogService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

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

    //日常易错
    @GetMapping("/weak")
    public ApiResponse<List<WeakKanaDTO>> getWeakKana() {
        return ApiResponse.success(kanaAnswerLogService.getWeakKana());
    }

    //历史易错
    @GetMapping("/weak/history")
    public ApiResponse<List<WeakKanaDTO>> getWeakKanaHistory(
            @RequestParam(required = false)
            @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate startDate,
            @RequestParam(required = false)
            @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate endDate) {
        return ApiResponse.success(kanaAnswerLogService.getWeakKanaHistory(startDate,endDate));
    }

    //最近封存时间
    @GetMapping("/last-archived")
    public ApiResponse<LocalDateTime> getLastArchivedAt() {
        return ApiResponse.success(kanaAnswerLogService.getLastArchivedAt());
    }

    //历史统计范围
    @GetMapping("/history/range")
    public ApiResponse<KanaHistoryRangeDTO> getHistoryRange() {
        return ApiResponse.success(kanaAnswerLogService.getHistoryRange());
    }
}
