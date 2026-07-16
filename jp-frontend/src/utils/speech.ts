let cachedVoice: SpeechSynthesisVoice | null = null

export function initVoice() {
  const loadVoices = () => {
    const voices = speechSynthesis.getVoices()
    const jpVoices = voices.filter(v => v.lang.startsWith('ja'))
    if (jpVoices.length > 4) {
      cachedVoice = jpVoices[4]
    } else if (jpVoices.length > 0) {
      cachedVoice = jpVoices[0]
    }
    // 预热：播放一个极短的静音来初始化音频引擎
    warmUp()
  }
  loadVoices()
  speechSynthesis.addEventListener('voiceschanged', loadVoices)
}

// 预热函数：播放一个极短的静音
function warmUp() {
  const u = new SpeechSynthesisUtterance('')
  u.lang = 'ja-JP'
  u.volume = 0
  if (cachedVoice) u.voice = cachedVoice
  speechSynthesis.speak(u)
}

export function speakWord(text: string) {
  if (!text) return
  const u = new SpeechSynthesisUtterance(text)
  u.lang = 'ja-JP'
  u.rate = 0.85
  if (cachedVoice) u.voice = cachedVoice
  speechSynthesis.speak(u)
}
