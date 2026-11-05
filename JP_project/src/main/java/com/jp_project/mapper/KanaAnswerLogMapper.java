package com.jp_project.mapper;

import com.jp_project.dto.KanaHistoryRangeDTO;
import com.jp_project.dto.WeakKanaDTO;
import com.jp_project.entity.KanaAnswerLog;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.time.LocalDate;
import java.util.List;

@Mapper
public interface KanaAnswerLogMapper {

    // 批量插入一整场的答题记录（一条 SQL 插完，不是循环插 N 次）
    void batchInsert(@Param("list") List<KanaAnswerLog> records);

    // 把所有活跃记录封存（is_archived 0→1）
    void archiveAll();

    //易错
    List<WeakKanaDTO> selectWeakKana(
            @Param("isArchived") int isArchived,
            @Param("startDate") LocalDate startDate,
            @Param("endDate") LocalDate endDate
            );

    //历史统计范围
    KanaHistoryRangeDTO selectHistoryRange();
}
