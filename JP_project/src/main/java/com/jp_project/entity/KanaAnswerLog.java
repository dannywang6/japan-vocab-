package com.jp_project.entity;


import lombok.Data;
import java.time.LocalDateTime;

@Data
public class KanaAnswerLog {
    //自增主键
    private Long id;
    //假名
    private String itemKey;
    //对与错
    private Boolean isCorrect;
    //答题时间
    private LocalDateTime answeredAt;
}
