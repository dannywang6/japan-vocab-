package com.jp_project.dto;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class KanaHistoryRangeDTO {
    //已封存的最早记录时间
    private LocalDateTime firstAnsweredAt;
    //最近的一次封存时间
    private LocalDateTime lastArchivedAt;
}
