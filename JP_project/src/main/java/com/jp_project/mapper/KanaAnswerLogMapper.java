package com.jp_project.mapper;

import com.jp_project.entity.KanaAnswerLog;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface KanaAnswerLogMapper {

    // 批量插入一整场的答题记录（一条 SQL 插完，不是循环插 N 次）
    void batchInsert(@Param("list") List<KanaAnswerLog> records);

    // 把所有活跃记录封存（is_archived 0→1）。注意是 UPDATE 不是 DELETE，历史不丢
    void archiveAll();
}
