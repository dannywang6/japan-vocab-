package com.jp_project.dto;

import lombok.Data;
import java.math.BigDecimal;

@Data
public class WeakKanaDTO {
    //假名
    private String itemKey;
    //总次数
    private Long totalCount;
    //错误次数
    private Long wrongCount;
    //错误率
    private BigDecimal wrongRate;
}
