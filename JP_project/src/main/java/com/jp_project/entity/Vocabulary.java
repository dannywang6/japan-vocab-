package com.jp_project.entity;

import java.time.LocalDateTime;

import jakarta.validation.constraints.NotBlank;
import lombok.Data;

/**
 * 
 * @TableName vocabulary
 */
@Data
public class Vocabulary {
    /**
     * 
     */
    private Long id;

    /**
     * 假名
     */
    @NotBlank(message = "假名不能为空")
    private String kana;

    /**
     * 日汉字
     */
    private String kanji;

    /**
     * 罗马音
     */
    @NotBlank(message = "罗马音不能为空")
    private String romaji;

    /**
     * 中文意思
     */
    @NotBlank(message = "翻译不能为空")
    private String meaning;

    /**
     * 英文意思，可选
     */
    private String english;

    /**
     * 例句
     */
    private String example;

    /**
     * 备注
     */
    private String note;

    /**
     * 
     */
    private LocalDateTime createdAt;

    /**
     * 
     */
    private LocalDateTime updatedAt;

    /**
     * 是否重点词汇：0否，1是
     */
    private Integer important;

    /**
     * 例句翻译
     */
    private String exampleMeaning;

    /**
     * 词性
     */
    private String partOfSpeech;
}