package com.jp_project.dto;

import lombok.Data;
import java.util.List;

@Data
public class QuizQuestionDTO {
    private Long correctVocabId;   // 正确答案的vocabId，后端暂存用，不返回给前端
    private String quizType;       // cn_to_jp / jp_to_cn
    private String correctKana;
    private String correctKanji;
    private String correctRomaji;
    private String correctMeaning;
    private List<OptionDTO> options; // 四个选项

    @Data
    public static class OptionDTO {
        private Long vocabId;
        private String kana;
        private String kanji;
        private String romaji;
        private String meaning;
    }
}