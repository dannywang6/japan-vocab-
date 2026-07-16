package com.jp_project.mapper;

import com.jp_project.entity.Vocabulary;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * 针对 vocabulary 表的数据库操作 Mapper。
 */
@Mapper
public interface VocabularyMapper {

    List<Vocabulary> selectAll();

    int insert(Vocabulary vocabulary);

    Vocabulary selectById(Long id);

    int update(Vocabulary vocabulary);

    int deleteById(Long id);

    /** 按假名查重 */
    Vocabulary selectByKana(String kana);

    /** 按日汉字查重 */
    Vocabulary selectByKanji(String kanji);

    // 词汇库查询
    List<Vocabulary> search(String keyWord);
}
