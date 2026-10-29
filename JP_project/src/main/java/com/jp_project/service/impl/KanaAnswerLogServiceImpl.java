package com.jp_project.service.impl;

import com.jp_project.dto.KanaSessionDTO;
import com.jp_project.entity.KanaAnswerLog;
import com.jp_project.mapper.KanaAnswerLogMapper;
import com.jp_project.service.KanaAnswerLogService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

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

    @Override
    public void archiveAll() {
        kanaAnswerLogMapper.archiveAll();
    }
}
