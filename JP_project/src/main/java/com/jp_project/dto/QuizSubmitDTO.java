package com.jp_project.dto;

import jakarta.validation.constraints.NotNull;
import lombok.Data;

import java.util.List;

@Data
public class QuizSubmitDTO {
    @NotNull
    private Long correctVocabId;    // 题目的正确答案vocabId
    @NotNull
    private Long selectedVocabId;   // 用户选择的vocabId
    @NotNull
    private String quizType;        // cn_to_jp / jp_to_cn
    @NotNull
    private List<Long> allOptionIds;
}