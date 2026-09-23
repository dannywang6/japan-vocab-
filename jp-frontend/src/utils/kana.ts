export interface KanaItem {
  h: string
  k: string
  romaji: string
}

export interface KanaGroup {
  label: string
  kLabel: string
  items: KanaItem[]
}

const g = (label: string, kLabel: string, list: [string, string, string][]): KanaGroup => ({
  label,
  kLabel,
  items: list.map(([h, k, romaji]) => ({ h, k, romaji })),
})

export const KANA_GROUPS: KanaGroup[] = [
  g('あ行', 'ア行', [['あ', 'ア', 'a'], ['い', 'イ', 'i'], ['う', 'ウ', 'u'], ['え', 'エ', 'e'], ['お', 'オ', 'o']]),
  g('か行', 'カ行', [['か', 'カ', 'ka'], ['き', 'キ', 'ki'], ['く', 'ク', 'ku'], ['け', 'ケ', 'ke'], ['こ', 'コ', 'ko']]),
  g('さ行', 'サ行', [['さ', 'サ', 'sa'], ['し', 'シ', 'shi'], ['す', 'ス', 'su'], ['せ', 'セ', 'se'], ['そ', 'ソ', 'so']]),
  g('た行', 'タ行', [['た', 'タ', 'ta'], ['ち', 'チ', 'chi'], ['つ', 'ツ', 'tsu'], ['て', 'テ', 'te'], ['と', 'ト', 'to']]),
  g('な行', 'ナ行', [['な', 'ナ', 'na'], ['に', 'ニ', 'ni'], ['ぬ', 'ヌ', 'nu'], ['ね', 'ネ', 'ne'], ['の', 'ノ', 'no']]),
  g('は行', 'ハ行', [['は', 'ハ', 'ha'], ['ひ', 'ヒ', 'hi'], ['ふ', 'フ', 'fu'], ['へ', 'ヘ', 'he'], ['ほ', 'ホ', 'ho']]),
  g('ま行', 'マ行', [['ま', 'マ', 'ma'], ['み', 'ミ', 'mi'], ['む', 'ム', 'mu'], ['め', 'メ', 'me'], ['も', 'モ', 'mo']]),
  g('や行', 'ヤ行', [['や', 'ヤ', 'ya'], ['ゆ', 'ユ', 'yu'], ['よ', 'ヨ', 'yo']]),
  g('ら行', 'ラ行', [['ら', 'ラ', 'ra'], ['り', 'リ', 'ri'], ['る', 'ル', 'ru'], ['れ', 'レ', 're'], ['ろ', 'ロ', 'ro']]),
  g('わ行', 'ワ行', [['わ', 'ワ', 'wa'], ['を', 'ヲ', 'wo']]),
  g('ん', 'ン', [['ん', 'ン', 'n']]),
  g('が行', 'ガ行', [['が', 'ガ', 'ga'], ['ぎ', 'ギ', 'gi'], ['ぐ', 'グ', 'gu'], ['げ', 'ゲ', 'ge'], ['ご', 'ゴ', 'go']]),
  g('ざ行', 'ザ行', [['ざ', 'ザ', 'za'], ['じ', 'ジ', 'ji'], ['ず', 'ズ', 'zu'], ['ぜ', 'ゼ', 'ze'], ['ぞ', 'ゾ', 'zo']]),
  g('だ行', 'ダ行', [['だ', 'ダ', 'da'], ['ぢ', 'ヂ', 'ji'], ['づ', 'ヅ', 'zu'], ['で', 'デ', 'de'], ['ど', 'ド', 'do']]),
  g('ば行', 'バ行', [['ば', 'バ', 'ba'], ['び', 'ビ', 'bi'], ['ぶ', 'ブ', 'bu'], ['べ', 'ベ', 'be'], ['ぼ', 'ボ', 'bo']]),
  g('ぱ行', 'パ行', [['ぱ', 'パ', 'pa'], ['ぴ', 'ピ', 'pi'], ['ぷ', 'プ', 'pu'], ['ぺ', 'ペ', 'pe'], ['ぽ', 'ポ', 'po']]),
  g('きゃ行', 'キャ行', [['きゃ', 'キャ', 'kya'], ['きゅ', 'キュ', 'kyu'], ['きょ', 'キョ', 'kyo']]),
  g('しゃ行', 'シャ行', [['しゃ', 'シャ', 'sha'], ['しゅ', 'シュ', 'shu'], ['しょ', 'ショ', 'sho']]),
  g('ちゃ行', 'チャ行', [['ちゃ', 'チャ', 'cha'], ['ちゅ', 'チュ', 'chu'], ['ちょ', 'チョ', 'cho']]),
  g('にゃ行', 'ニャ行', [['にゃ', 'ニャ', 'nya'], ['にゅ', 'ニュ', 'nyu'], ['にょ', 'ニョ', 'nyo']]),
  g('ひゃ行', 'ヒャ行', [['ひゃ', 'ヒャ', 'hya'], ['ひゅ', 'ヒュ', 'hyu'], ['ひょ', 'ヒョ', 'hyo']]),
  g('みゃ行', 'ミャ行', [['みゃ', 'ミャ', 'mya'], ['みゅ', 'ミュ', 'myu'], ['みょ', 'ミョ', 'myo']]),
  g('りゃ行', 'リャ行', [['りゃ', 'リャ', 'rya'], ['りゅ', 'リュ', 'ryu'], ['りょ', 'リョ', 'ryo']]),
  g('ぎゃ行', 'ギャ行', [['ぎゃ', 'ギャ', 'gya'], ['ぎゅ', 'ギュ', 'gyu'], ['ぎょ', 'ギョ', 'gyo']]),
  g('じゃ行', 'ジャ行', [['じゃ', 'ジャ', 'ja'], ['じゅ', 'ジュ', 'ju'], ['じょ', 'ジョ', 'jo']]),
  g('びゃ行', 'ビャ行', [['びゃ', 'ビャ', 'bya'], ['びゅ', 'ビュ', 'byu'], ['びょ', 'ビョ', 'byo']]),
  g('ぴゃ行', 'ピャ行', [['ぴゃ', 'ピャ', 'pya'], ['ぴゅ', 'ピュ', 'pyu'], ['ぴょ', 'ピョ', 'pyo']]),
]

export const BASIC_GROUPS = KANA_GROUPS.slice(0, 11)

export interface Speaker { id: number; label: string; desc: string }

export const SPEAKERS: Speaker[] = [
  { id: 0, label: '声音 1', desc: '女声' },
  { id: 1, label: '声音 2', desc: '男声' },
  { id: 2, label: '声音 3', desc: '女声' },
  { id: 3, label: '声音 4', desc: '女声' },
  { id: 4, label: '声音 5', desc: '男声' },
]

export function audioUrl(speaker: number, romaji: string): string {
  return `${import.meta.env.BASE_URL}kana/${speaker}/${romaji}.mp3`
}

export function flatten(): KanaItem[] {
  return KANA_GROUPS.flatMap((group) => group.items)
}

export function displayChar(item: KanaItem, script: 'hiragana' | 'katakana'): string {
  return script === 'hiragana' ? item.h : item.k
}

export function groupLabel(group: KanaGroup, script: 'hiragana' | 'katakana'): string {
  return script === 'katakana' ? group.kLabel : group.label
}