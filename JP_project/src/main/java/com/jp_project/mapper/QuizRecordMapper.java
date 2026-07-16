package com.jp_project.mapper;

import com.jp_project.entity.QuizRecord;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import java.util.List;

@Mapper
public interface QuizRecordMapper {

    // 插入答题记录
    void insert(QuizRecord record);

    // 查最近答错的词id列表（用于生成干扰项）
    List<Long> selectRecentWrongVocabIds(@Param("limit") int limit);

    // play池中抽取错过的单词测试
    List<Long> selectAllWrongVocabIds();
}