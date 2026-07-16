package com.jp_project.entity;

import lombok.Data;
import java.time.LocalDateTime;

@Data
public class QuizRecord {
    private Long id;
    private Long vocabId;
    private String quizType;
    private Boolean isCorrect;
    private LocalDateTime answeredAt;
}