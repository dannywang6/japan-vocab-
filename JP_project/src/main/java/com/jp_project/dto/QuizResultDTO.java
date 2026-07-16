package com.jp_project.dto;

import com.jp_project.entity.Vocabulary;
import lombok.Data;
import java.util.List;

@Data
public class QuizResultDTO {
    private Boolean correct;          // 是否答对
    private Long correctVocabId;      // 正确答案vocabId，前端用来高亮
    private Long selectedVocabId;     // 用户选的vocabId，前端用来标红
    private List<Vocabulary> allOptions; // 四个选项完整信息
}