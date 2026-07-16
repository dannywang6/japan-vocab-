package com.jp_project.controller;


import com.jp_project.common.ApiResponse;
import com.jp_project.dto.AnalyzeRequestDTO;
import com.jp_project.dto.AnalyzeResultDTO;
import com.jp_project.entity.Vocabulary;
import com.jp_project.service.VocabularyService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/vocabularies")
@RequiredArgsConstructor
public class VocabularyController {

    private final VocabularyService vocabularyService;

    @GetMapping
    public ApiResponse<List<Vocabulary>> listAll() {

        return ApiResponse.success(vocabularyService.listAll());
    }

    @PostMapping
    public ApiResponse<Void> addVocabulary(@Valid @RequestBody Vocabulary vocabulary) {
        vocabularyService.addVocabulary(vocabulary);
        return ApiResponse.success("添加成功", null);
    }

    @GetMapping("/{id}")
    public ApiResponse<Vocabulary> getById(@PathVariable Long id) {
        return ApiResponse.success(vocabularyService.getById(id));
    }

    @PutMapping("/{id}")
    public ApiResponse<Void> updateVocabulary(
            @PathVariable Long id,
            @Valid @RequestBody Vocabulary vocabulary
    ) {
        vocabulary.setId(id);
        vocabularyService.updateVocabulary(vocabulary);
        return ApiResponse.success("修改成功", null);
    }

    @DeleteMapping("/{id}")
    public ApiResponse<Void> deleteVocabulary(@PathVariable Long id) {
        vocabularyService.deleteVocabulary(id);
        return ApiResponse.success("删除成功", null);
    }

    /** 自动填充：解析单词，返回假名、汉字、罗马字、中文、英文 */
    @PostMapping("/analyze")
    public ApiResponse<AnalyzeResultDTO> analyzeWord(@RequestBody AnalyzeRequestDTO request) {
        AnalyzeResultDTO result = vocabularyService.analyzeWord(request.getWord());
        return ApiResponse.success(result);
    }

    // 全局搜索
    @GetMapping("/search")
    public ApiResponse<List<Vocabulary>> search(@RequestParam String keyword) {
        return ApiResponse.success(vocabularyService.search(keyword));
    }

}
