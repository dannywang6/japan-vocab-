package com.jp_project.mapper;

import com.jp_project.entity.Vocabulary;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import java.util.List;

@Mapper
public interface QuizMapper {

    // 随机取一个词（排除指定id）
    Vocabulary selectRandomExcludeIds(@Param("excludeIds") List<Long> excludeIds);

    // 批量按id查词汇（用于返回选项完整信息）
    List<Vocabulary> selectByIds(@Param("ids") List<Long> ids);
}