package com.jp_project.entity;

import lombok.Data;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Data
public class StudyRecord {
    private Long id;
    private Long vocabId;
    private Integer reviewStage;
    private LocalDate nextReviewAt;
    private LocalDateTime lastReviewedAt;
    private LocalDateTime createdAt;
}