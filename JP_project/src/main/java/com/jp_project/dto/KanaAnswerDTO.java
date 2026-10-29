package com.jp_project.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

// 一条答题记录（前端 results 数组里的一个元素）
@Data
public class KanaAnswerDTO {
    @NotBlank private String itemKey;   // 假名 key，如 "あ"

    @NotNull private Boolean correct;   // 故意叫 correct 不叫 isCorrect —— 要和前端 KanaAnswer 字段名对齐
}
