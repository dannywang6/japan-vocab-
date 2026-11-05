package com.jp_project.service;

import com.jp_project.dto.KanaHistoryRangeDTO;
import com.jp_project.dto.KanaSessionDTO;
import com.jp_project.dto.WeakKanaDTO;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

public interface KanaAnswerLogService {

    void submitSession(KanaSessionDTO dto);

    void archiveAll();

    List<WeakKanaDTO> getWeakKana();

    List<WeakKanaDTO> getWeakKanaHistory(LocalDate start, LocalDate end);

    LocalDateTime getLastArchivedAt();

    KanaHistoryRangeDTO getHistoryRange();

}
