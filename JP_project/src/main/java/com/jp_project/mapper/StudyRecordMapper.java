package com.jp_project.mapper;


import com.jp_project.entity.StudyRecord;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.time.LocalDate;
import java.util.List;

@Mapper
public interface StudyRecordMapper {
    //新增学习记录
    void insert(StudyRecord record);

    //按vocabId查询
    StudyRecord selectByVocabId(Long vocabId);

    //查今日待复习项目
    List<StudyRecord> selectByNextReviewDate(@Param("date")LocalDate date);

    //更新复习阶段和下次复习日期
    void update(StudyRecord record);

    //判断某个词是否加入复习计划
    boolean existsByVocabId(Long vocabId);

    // 按ID删除
    int deleteByVocabId(Long vocabId);

}
