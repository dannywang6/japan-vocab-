package com.jp_project.dto;

import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

import java.util.List;

// 一整场测验/拼写的成绩单（对应前端发的 { items: [...] }）
@Data
public class KanaSessionDTO {
    @NotNull @NotEmpty private List<KanaAnswerDTO> items;
}
