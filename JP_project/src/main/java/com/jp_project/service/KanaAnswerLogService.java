package com.jp_project.service;

import com.jp_project.dto.KanaSessionDTO;

public interface KanaAnswerLogService {
    void submitSession(KanaSessionDTO dto);
    void archiveAll();

}
