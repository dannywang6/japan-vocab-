package com.jp_project.util;

import java.util.LinkedHashMap;
import java.util.Map;

import static org.springframework.http.RequestEntity.put;

public class JapaneseUtil {

    //假名->罗马字 映射

    private static final Map<String, String> HIRAGANA_TO_ROMAJI = new LinkedHashMap<>();

    static {
        // ---- 五十音（清音） ----
        put("あ", "a"); put("い", "i"); put("う", "u"); put("え", "e"); put("お", "o");
        put("か", "ka"); put("き", "ki"); put("く", "ku"); put("け", "ke"); put("こ", "ko");
        put("さ", "sa"); put("し", "shi"); put("す", "su"); put("せ", "se"); put("そ", "so");
        put("た", "ta"); put("ち", "chi"); put("つ", "tsu"); put("て", "te"); put("と", "to");
        put("な", "na"); put("に", "ni"); put("ぬ", "nu"); put("ね", "ne"); put("の", "no");
        put("は", "ha"); put("ひ", "hi"); put("ふ", "fu"); put("へ", "he"); put("ほ", "ho");
        put("ま", "ma"); put("み", "mi"); put("む", "mu"); put("め", "me"); put("も", "mo");
        put("や", "ya"); put("ゆ", "yu"); put("よ", "yo");
        put("ら", "ra"); put("り", "ri"); put("る", "ru"); put("れ", "re"); put("ろ", "ro");
        put("わ", "wa"); put("を", "wo"); put("ん", "n");

        // ---- 濁音 ----
        put("が", "ga"); put("ぎ", "gi"); put("ぐ", "gu"); put("げ", "ge"); put("ご", "go");
        put("ざ", "za"); put("じ", "ji"); put("ず", "zu"); put("ぜ", "ze"); put("ぞ", "zo");
        put("だ", "da"); put("ぢ", "ji"); put("づ", "zu"); put("で", "de"); put("ど", "do");
        put("ば", "ba"); put("び", "bi"); put("ぶ", "bu"); put("べ", "be"); put("ぼ", "bo");

        // ---- 半濁音 ----
        put("ぱ", "pa"); put("ぴ", "pi"); put("ぷ", "pu"); put("ぺ", "pe"); put("ぽ", "po");

        // ---- 拗音（2文字で1音） ----
        put("きゃ", "kya"); put("きゅ", "kyu"); put("きょ", "kyo");
        put("ぎゃ", "gya"); put("ぎゅ", "gyu"); put("ぎょ", "gyo");
        put("しゃ", "sha"); put("しゅ", "shu"); put("しょ", "sho");
        put("じゃ", "ja");  put("じゅ", "ju");  put("じょ", "jo");
        put("ちゃ", "cha"); put("ちゅ", "chu"); put("ちょ", "cho");
        put("ぢゃ", "ja");  put("ぢゅ", "ju");  put("ぢょ", "jo");
        put("にゃ", "nya"); put("にゅ", "nyu"); put("にょ", "nyo");
        put("ひゃ", "hya"); put("ひゅ", "hyu"); put("ひょ", "hyo");
        put("びゃ", "bya"); put("びゅ", "byu"); put("びょ", "byo");
        put("ぴゃ", "pya"); put("ぴゅ", "pyu"); put("ぴょ", "pyo");
        put("みゃ", "mya"); put("みゅ", "myu"); put("みょ", "myo");
        put("りゃ", "rya"); put("りゅ", "ryu"); put("りょ", "ryo");
    }

    private static void put(String kana, String romaji) {
        HIRAGANA_TO_ROMAJI.put(kana, romaji);
    }

    //片假名 -> 平假名
    public static String katakanaToHiragana(String katakana) {
        if (katakana == null) return "";
        StringBuilder sb = new StringBuilder();
        for (char ch : katakana.toCharArray()) {
            if (ch >= 'ァ' && ch <= 'ヶ') {
                sb.append((char) (ch - 0x60));
            } else {
                sb.append(ch);
            }
        }
        return sb.toString();
    }
    //平假名 -> 罗马音
    public static String hiraganaToRomaji(String hiragana) {
        if (hiragana == null || hiragana.isEmpty()) return "";
        StringBuilder sb = new StringBuilder();
        int i = 0;
        while (i < hiragana.length()) {
            String cur = String.valueOf(hiragana.charAt(i));

            if ("っ".equals(cur)) {
                i++;
                if (i < hiragana.length()) {
                    String next = HIRAGANA_TO_ROMAJI.get(String.valueOf(hiragana.charAt(i)));
                    if (next != null && !next.isEmpty()) {
                        sb.append(next.charAt(0));
                    }
                }
                continue;
            }
            //先尝试匹配2个词(拗音)
            if (i + 1 < hiragana.length()) {
                String two = hiragana.substring(i, i + 2);
                String r = HIRAGANA_TO_ROMAJI.get(two);
                if (r != null) {
                    sb.append(r);
                    i += 2;
                    continue;
                }
            }
            //匹配1字
            String r = HIRAGANA_TO_ROMAJI.get(cur);
            if (r != null) {
                sb.append(r);
            }
            i++;
        }
        return sb.toString();
    }

    //判断字符串内是否包含中文字符
    /**
     * 判断字符串是否包含中文汉字（用于检测用户输入的是中文还是日文）
     * CJK 统一表意文字范围：U+4E00 - U+9FFF
     */
    public static boolean containsChinese(String str) {
        if (str == null || str.isEmpty()) return false;
        for (char ch : str.toCharArray()) {
            if (ch >= 0x4E00 && ch <= 0x9FFF) return true;
        }
        return false;
    }

    /**
     * 判断字符串是否包含平假名或片假名
     * 平假名：U+3040 - U+309F
     * 片假名：U+30A0 - U+30FF
     */
    public static boolean containsKana(String str) {
        if (str == null || str.isEmpty()) return false;
        for (char ch : str.toCharArray()) {
            if ((ch >= 0x3040 && ch <= 0x309F) || (ch >= 0x30A0 && ch <= 0x30FF)) {
                return true;
            }
        }
        return false;
    }

    /**
     * 判断字符串是否纯 ASCII（英文）
     */
    public static boolean isAscii(String str) {
        if (str == null || str.isEmpty()) return false;
        for (char ch : str.toCharArray()) {
            if (ch > 127) return false;
        }
        return true;
    }
}
