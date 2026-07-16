package com.jp_project.dto;

import com.jp_project.entity.Vocabulary;
import lombok.Data;
import java.util.List;

@Data
public class TodayReviewDTO {
    private Integer totalCount;       // 今日待复习总数
    private List<Vocabulary> vocabList; // 待复习词汇完整信息
}