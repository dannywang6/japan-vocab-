package com.jp_project.service.impl;

import com.jp_project.dto.KanaHistoryRangeDTO;
import com.jp_project.dto.KanaSessionDTO;
import com.jp_project.dto.WeakKanaDTO;
import com.jp_project.entity.KanaAnswerLog;
import com.jp_project.mapper.KanaAnswerLogMapper;
import com.jp_project.service.KanaAnswerLogService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

@Service
@RequiredArgsConstructor
public class KanaAnswerLogServiceImpl implements KanaAnswerLogService {

    private final KanaAnswerLogMapper kanaAnswerLogMapper;

    @Override
    public void submitSession(KanaSessionDTO dto) {
        //防御空数组
        if(dto.getItems() == null || dto.getItems().isEmpty()) {
            return;
        }
        // DTO -> Entity
        List<KanaAnswerLog> records = dto.getItems().stream()
                .map(a -> {
                    KanaAnswerLog r = new KanaAnswerLog();
                    r.setItemKey(a.getItemKey());
                    r.setIsCorrect(a.getCorrect());
                    return r;
                }).toList();

        //插入数据库
        kanaAnswerLogMapper.batchInsert(records);
    }

    //把所有活跃记录封存（is_archived 0→1）
    @Override
    public void archiveAll() {
        kanaAnswerLogMapper.archiveAll();
    }

    //日常错误率查询
    @Override
    public List<WeakKanaDTO> getWeakKana() {
        return kanaAnswerLogMapper.selectWeakKana(0,null,null);
    }

    //历史错误率查询
    @Override
    public List<WeakKanaDTO> getWeakKanaHistory(LocalDate start, LocalDate end) {
        //若传入参数为空 返回空集合
        if (start == null || end == null || start.isAfter(end)) {
            return List.of();
        }
        return kanaAnswerLogMapper.selectWeakKana(1, start, end);
    }

    //最近封存时间查询
    @Override
    public LocalDateTime getLastArchivedAt() {
        return kanaAnswerLogMapper.selectHistoryRange().getLastArchivedAt();
    }

    //历史范围查询
    @Override
    public KanaHistoryRangeDTO getHistoryRange() {
        return kanaAnswerLogMapper.selectHistoryRange();
    }
}
