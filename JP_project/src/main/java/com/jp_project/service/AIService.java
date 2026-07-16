package com.jp_project.service;


import com.jp_project.dto.AnalyzeResultDTO;

public interface AIService {
    AnalyzeResultDTO analyzeWord(String word);
}
