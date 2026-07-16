package com.jp_project.dto;


import lombok.Data;

/**
 * 返回前端
 */
@Data
public class AnalyzeResultDTO {
    private String kana;
    private String kanji;
    private String romaji;
    private String meaning;
    private String english;
    private boolean duplicate;
    private String message;
}
