<template>
  <div class="dictation-page">
    <div class="mode-switch">
      <el-radio-group v-model="mode" size="large">
        <el-radio-button value="quiz">测验模式</el-radio-button>
        <el-radio-button value="dictation">听写模式</el-radio-button>
      </el-radio-group>
      <el-radio-group v-model="script" size="large" style="margin-left: 12px">
        <el-radio-button value="hiragana">平假名</el-radio-button>
        <el-radio-button value="katakana">片假名</el-radio-button>
      </el-radio-group>
    </div>

    <!-- 设置区 -->
    <div v-if="!running && !finished" class="panel">
      <div class="section-title">选择要听写的假名（可按行多选）</div>
      <div class="quick-row">
        <el-button size="small" @click="applyGroups(BASIC_LABELS)">基础</el-button>
        <el-button size="small" @click="applyGroups(DAKUON_LABELS)">浊音</el-button>
        <el-button size="small" @click="applyGroups(YOUON_LABELS)">拗音</el-button>
        <el-button size="small" @click="applyGroups(ALL_LABELS)">全选</el-button>
        <el-button size="small" @click="applyGroups([])">清空</el-button>
        <el-tag size="small" type="info" effect="plain">已选 {{ pool.length }} 个</el-tag>
      </div>
      <div class="group-grid">
        <div
          v-for="group in KANA_GROUPS"
          :key="group.label"
          class="group-card"
          :class="{ active: isGroupSelected(group.label) }"
          @click="toggleGroup(group.label)">
          <div class="group-label">{{ groupLabel(group, script) }}</div>
          <div class="group-kana">{{ group.items.map(i => displayChar(i, script)).join(' ') }}</div>
        </div>
      </div>

      <div v-if="mode === 'dictation'" class="row">
        <div class="row-label">听写数量</div>
        <el-radio-group v-model="countSel" size="default">
          <el-radio-button value="all">全部 ({{ maxCount }})</el-radio-button>
          <el-radio-button value="5">5</el-radio-button>
          <el-radio-button value="10">10</el-radio-button>
          <el-radio-button value="15">15</el-radio-button>
          <el-radio-button value="20">20</el-radio-button>
          <el-radio-button value="custom">自定义</el-radio-button>
        </el-radio-group>
        <el-input-number
          v-if="countSel === 'custom'"
          v-model="customCount"
          :min="1"
          :max="maxCount"
          style="margin-left: 12px" />
      </div>

      <div class="row">
        <div class="row-label">发音人</div>
        <el-radio-group v-model="speaker" size="default">
          <el-radio-button v-for="s in SPEAKERS" :key="s.id" :value="s.id">
            {{ s.label }} ({{ s.desc }})
          </el-radio-button>
        </el-radio-group>
      </div>

      <el-button
        type="primary"
        size="large"
        :disabled="pool.length === 0"
        @click="start">
        {{ mode === 'dictation' ? '开始听写' : '开始测验' }}
      </el-button>
      <el-alert
        v-if="pool.length === 0"
        type="warning"
        :closable="false"
        title="请至少选择一行的假名"
        style="margin-top: 12px" />
    </div>

    <!-- 听写播放中 -->
    <div v-else-if="running && mode === 'dictation'" class="panel center">
      <div class="progress-text">第 {{ index + 1 }} / {{ order.length }} 题</div>
      <el-tag v-if="rep === 1" type="warning" effect="plain" style="margin-top: 10px">第 1 遍</el-tag>
      <el-tag v-else type="success" effect="plain" style="margin-top: 10px">第 2 遍</el-tag>
      <el-progress
        :percentage="Math.round(((index + 1) / Math.max(order.length, 1)) * 100)"
        :stroke-width="12"
        style="max-width: 480px; margin: 16px 0" />
      <div class="play-light" :class="{ on: playingNow }">🔊 播放中…</div>
      <div class="btn-row">
        <el-button @click="replayCurrent">🔁 重播本题</el-button>
        <el-button @click="replayAll">重播全部</el-button>
        <el-button type="danger" plain @click="stop">停止</el-button>
      </div>
    </div>

    <!-- 测验进行中 -->
    <div v-else-if="running && mode === 'quiz'" class="panel center">
      <div class="score-bar">
        <el-tag type="success">正确 {{ correctCount }}</el-tag>
        <el-tag type="danger">错误 {{ totalCount - correctCount }}</el-tag>
        <el-button size="small" @click="reveal">答案</el-button>
        <el-button size="small" @click="skip">跳过</el-button>
        <el-button size="small" type="danger" plain @click="stopQuiz">结束</el-button>
        <el-button size="small" @click="replayQuestion">🔊 重播</el-button>
      </div>
      <div class="quiz-grid">
        <div
          v-for="item in quizPool"
          :key="displayChar(item, script)"
          class="quiz-card"
          :class="[...(highlight[displayChar(item, script)] ? [highlight[displayChar(item, script)]] : [])]"
          @click="answer(item)">
          {{ displayChar(item, script) }}
        </div>
      </div>
      <div v-if="revealed" class="reveal-tip">
        本题答案：<strong>{{ answeredChar }}</strong>
      </div>
    </div>

    <!-- 听写结果 -->
    <div v-else-if="finished && mode === 'dictation'" class="panel">
      <el-alert type="success" :closable="false" title="听写完毕，对照下面的顺序检查你写的答案吧" />
      <div class="answer-list">
        <div v-for="(item, i) in order" :key="i" class="answer-row">
          <span class="answer-no">{{ i + 1 }}</span>
          <span class="answer-kana">{{ item.h }} / {{ item.k }}</span>
          <span class="answer-romaji">{{ item.romaji }}</span>
          <span class="answer-row-label">{{ groupLabelOf(item) }}</span>
          <el-button size="small" text type="primary" @click="replayItem(item)">🔊</el-button>
        </div>
      </div>
      <div class="btn-row">
        <el-button @click="replayAll">再放一遍</el-button>
        <el-button type="primary" @click="reset">重新听写</el-button>
      </div>
    </div>

    <!-- 测验结果 -->
    <div v-else-if="finished && mode === 'quiz'" class="panel center">
      <el-result icon="success" title="测验结束">
        <template #sub-title>
          正确 {{ correctCount }} / {{ totalCount }}
        </template>
      </el-result>
      <el-button type="primary" @click="reset">再来一次</el-button>
    </div>
  </div>
</template>

<script setup lang="ts">
import { computed, onUnmounted, ref, watch } from "vue";
import { KANA_GROUPS, SPEAKERS, audioUrl, displayChar, groupLabel } from "../utils/kana";
import type { KanaItem } from "../utils/kana";
import { ElMessage } from "element-plus";

type Mode = "quiz" | "dictation";
type Script = "hiragana" | "katakana";

const mode = ref<Mode>("dictation");
const script = ref<Script>("hiragana");
const speaker = ref(0);
const selectedGroups = ref<string[]>(KANA_GROUPS.slice(0, 11).map(g => g.label));
const countSel = ref<string>("all");
const customCount = ref(5);

const running = ref(false);
const finished = ref(false);
const order = ref<KanaItem[]>([]);
const index = ref(0);
const playingNow = ref(false);

const correctCount = ref(0);
const totalCount = ref(0);
const current = ref<KanaItem | null>(null);
const quizPool = ref<KanaItem[]>([]);
const solved = ref(false);
const highlight = ref<Record<string, "correct" | "wrong">>({});
const revealed = ref(false);
const answeredChar = ref("");

const ALL_LABELS = KANA_GROUPS.map(g => g.label);
const BASIC_LABELS = KANA_GROUPS.slice(0, 11).map(g => g.label);
const DAKUON_LABELS = KANA_GROUPS.slice(11, 16).map(g => g.label);
const YOUON_LABELS = KANA_GROUPS.slice(16).map(g => g.label);

let audio: HTMLAudioElement | null = null;
let timer: ReturnType<typeof setTimeout> | null = null;

const isGroupSelected = (label: string) => selectedGroups.value.includes(label);

function toggleGroup(label: string) {
  if (selectedGroups.value.includes(label)) {
    if (selectedGroups.value.length === 1) return
    selectedGroups.value = selectedGroups.value.filter(l => l !== label)
  } else {
    selectedGroups.value = [...selectedGroups.value, label]
  }
  if (countSel.value === 'custom' && customCount.value > maxCount.value) {
    customCount.value = maxCount.value
  }
}

function applyGroups(labels: string[]) {
  selectedGroups.value = labels
  if (countSel.value === 'custom' && customCount.value > maxCount.value) {
    customCount.value = maxCount.value
  }
}

const pool = computed<KanaItem[]>(() =>
  KANA_GROUPS.filter(g => selectedGroups.value.includes(g.label))
    .flatMap(g => g.items)
)

const maxCount = computed(() => pool.value.length)

const dictCount = computed(() =>
  countSel.value === "custom"
    ? Math.min(customCount.value, maxCount.value)
    : countSel.value === "all"
      ? maxCount.value
      : Math.min(Number(countSel.value), maxCount.value)
)

function shuffle<T>(arr: T[]): T[] {
  const a = [...arr]
  for (let i = a.length - 1; i > 0; i--) {
    const j = Math.floor(Math.random() * (i + 1))
    ;[a[i], a[j]] = [a[j], a[i]]
  }
  return a
}

const rep = ref(1);

function play(kana: KanaItem) {
  rep.value = 1
  playOnce(kana)
  clearSchedule()
  timer = setTimeout(() => {
    if (!running.value) return
    rep.value = 2
    playOnce(kana)
    clearSchedule()
    timer = setTimeout(() => {
      if (running.value) nextInDictation()
    }, 2000)
  }, 2000)
}

function playOnce(kana: KanaItem) {
  playingNow.value = true
  if (audio) {
    audio.src = audioUrl(speaker.value, kana.romaji)
    audio.play().catch(() => {
      ElMessage.warning("音频播放被浏览器拦截，请先点击页面任意位置")
      playingNow.value = false
    })
  } else {
    audio = new Audio(audioUrl(speaker.value, kana.romaji))
    audio.play()
  }
}

function clearSchedule() {
  if (timer) {
    clearTimeout(timer)
    timer = null
  }
}

function start() {
  if (pool.value.length === 0) return
  if (mode.value === "dictation") {
    order.value = shuffle(pool.value).slice(0, dictCount.value)
    index.value = 0
    finished.value = false
    running.value = true
    play(order.value[0])
  } else {
    correctCount.value = 0
    totalCount.value = 0
    solved.value = false
    quizPool.value = shuffle(pool.value)
    finished.value = false
    running.value = true
    newQuestion()
  }
}

function nextInDictation() {
  index.value += 1
  if (index.value >= order.value.length) {
    playingNow.value = false
    running.value = false
    finished.value = true
    return
  }
  play(order.value[index.value])
}

function replayCurrent() {
  if (order.value[index.value]) play(order.value[index.value])
}

function replayAll() {
  if (order.value.length === 0) return
  index.value = 0
  finished.value = false
  running.value = true
  play(order.value[0])
}

function stop() {
  clearSchedule()
  if (audio) audio.pause()
  playingNow.value = false
  running.value = false
}

function newQuestion() {
  const poolArr = pool.value
  if (poolArr.length === 0) return
  let next = poolArr[Math.floor(Math.random() * poolArr.length)]
  if (current.value && poolArr.length > 1) {
    let guard = 0
    while (next.romaji === current.value.romaji && guard++ < 10) {
      next = poolArr[Math.floor(Math.random() * poolArr.length)]
    }
  }
  current.value = next
  solved.value = false
  revealed.value = false
  answeredChar.value = displayChar(next, script.value)
  highlight.value = {}
  playQuestion(next)
}

function playQuestion(kana: KanaItem) {
  playingNow.value = true
  if (audio) {
    audio.src = audioUrl(speaker.value, kana.romaji)
    audio.play().catch(() => {})
  } else {
    audio = new Audio(audioUrl(speaker.value, kana.romaji))
    audio.play()
  }
}

function answer(item: KanaItem) {
  if (!running.value || mode.value !== "quiz" || !current.value || solved.value) return
  const char = displayChar(item, script.value)
  const answerChar = displayChar(current.value, script.value)
  const isCorrect = item.romaji === current.value.romaji
  solved.value = true
  clearSchedule()
  if (isCorrect) {
    highlight.value = char === answerChar
      ? { [char]: "correct" }
      : { [char]: "correct", [answerChar]: "correct" }
    correctCount.value += 1
    totalCount.value += 1
    timer = setTimeout(newQuestion, 1200)
  } else {
    highlight.value = { [char]: "wrong" }
    totalCount.value += 1
    timer = setTimeout(newQuestion, 800)
  }
}

function reveal() {
  if (!running.value || !current.value) return
  revealed.value = true
  answeredChar.value = displayChar(current.value, script.value)
  highlight.value = { [answeredChar.value]: "correct" }
}

function skip() {
  if (!running.value) return
  clearSchedule()
  newQuestion()
}

function stopQuiz() {
  clearSchedule()
  playingNow.value = false
  running.value = false
  finished.value = true
}

function replayQuestion() {
  if (running.value && current.value) playQuestion(current.value)
}

function groupLabelOf(item: KanaItem): string {
  return KANA_GROUPS.find(g => g.items.includes(item))?.label ?? ""
}

function replayItem(item: KanaItem) {
  playOnce(item)
}

function reset() {
  stop()
  finished.value = false
  current.value = null
  highlight.value = {}
}

watch([mode, script], () => reset())

onUnmounted(() => {
  clearSchedule()
  if (audio) audio.pause()
  audio = null
})
</script>

<style scoped>
.mode-switch {
  display: flex;
  flex-wrap: wrap;
  gap: 8px;
  margin-bottom: 16px;
}

.panel {
  background: var(--bg-card);
  border: 1px solid var(--border);
  border-radius: 10px;
  padding: 20px;
}

.panel.center {
  text-align: center;
}

.section-title {
  font-size: 15px;
  font-weight: 500;
  color: var(--text);
  margin-bottom: 12px;
}

.group-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(130px, 1fr));
  gap: 10px;
  margin-bottom: 16px;
}

.quick-row {
  display: flex;
  align-items: center;
  flex-wrap: wrap;
  gap: 8px;
  margin-bottom: 12px;
}

.group-card {
  border: 1px solid var(--border);
  border-radius: 8px;
  padding: 10px 12px;
  cursor: pointer;
  transition: border-color 0.15s, background 0.15s;
}

.group-card:hover,
.group-card.active {
  border-color: #534ab7;
  background: #fbfbff;
}

html.dark .group-card:hover,
html.dark .group-card.active {
  background: var(--mode-active-bg);
}

.group-label {
  font-size: 13px;
  font-weight: 500;
  color: var(--text);
  margin-bottom: 4px;
}

.group-kana {
  font-size: 12px;
  color: var(--text-muted);
  word-break: break-all;
  line-height: 1.6;
}

.row {
  display: flex;
  align-items: center;
  flex-wrap: wrap;
  gap: 8px;
  margin-bottom: 16px;
}

.row-label {
  font-size: 14px;
  color: var(--text-secondary);
  margin-right: 4px;
}

.progress-text {
  font-size: 28px;
  font-weight: 500;
  color: var(--text);
}

.play-light {
  font-size: 16px;
  color: var(--text-muted);
  margin-bottom: 12px;
}

.play-light.on {
  animation: blink 1s ease-in-out infinite;
}

@keyframes blink {
  0%, 100% { opacity: 0.3; }
  50% { opacity: 1; }
}

.btn-row {
  display: flex;
  flex-wrap: wrap;
  gap: 10px;
  justify-content: center;
  margin-top: 14px;
}

.score-bar {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 10px;
  flex-wrap: wrap;
  margin-bottom: 16px;
}

.quiz-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(72px, 1fr));
  gap: 8px;
}

.quiz-card {
  border: 1px solid var(--border);
  border-radius: 8px;
  padding: 14px 8px;
  font-size: 26px;
  text-align: center;
  cursor: pointer;
  background: var(--bg-card);
  color: var(--text);
  transition: all 0.15s;
  user-select: none;
}

.quiz-card:hover {
  border-color: #afa9ec;
  background: #eeedfe;
}

.quiz-card.correct {
  background: var(--correct-bg);
  border-color: var(--correct-border);
  color: var(--correct-text);
}

.quiz-card.wrong {
  background: var(--wrong-bg);
  border-color: var(--wrong-border);
  color: var(--wrong-text);
}

.reveal-tip {
  margin-top: 14px;
  font-size: 18px;
  color: var(--text);
}

.answer-list {
  margin-top: 16px;
  display: flex;
  flex-direction: column;
  gap: 6px;
}

.answer-row {
  display: flex;
  align-items: center;
  gap: 12px;
  padding: 8px 12px;
  border: 1px solid var(--border);
  border-radius: 8px;
}

.answer-no {
  font-size: 13px;
  color: var(--text-muted);
  min-width: 24px;
}

.answer-kana {
  font-size: 24px;
  font-weight: 500;
  color: var(--text);
}

.answer-romaji {
  font-size: 15px;
  color: var(--text-secondary);
}

.answer-row-label {
  margin-left: auto;
  font-size: 12px;
  color: var(--text-muted);
}
</style>