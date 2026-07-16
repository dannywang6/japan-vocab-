package com.jp_project.service;

import com.jp_project.dto.QuizQuestionDTO;
import com.jp_project.dto.QuizResultDTO;
import com.jp_project.dto.QuizSubmitDTO;

import java.util.List;

public interface QuizService {

    // 生成一道题
    QuizQuestionDTO generateQuestion(String quizType);

    // 提交答案，返回结果
    QuizResultDTO submitAnswer(QuizSubmitDTO submitDTO);

    //确认出错,存到数据库
    void confirmMistakes(List<Long> vocabIds);
}