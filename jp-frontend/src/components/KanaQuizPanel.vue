<template>
  <!--
    KanaQuizPanel = 测验模式面板（听写页三个功能面板之一）
    玩法：自动朗读一个假名 → 你在九宫格里点你认为对的格子 → 对/错高亮 + 自动进下一题
    结构：running=true 答题中 / running=false 结束页（父页监听 @reset 回设置区）
  -->
  <!-- ===== 答题中 ===== -->
  <div v-if="running" class="panel center">
    <!-- 顶部工具条：成绩统计 + 答案/跳过/结束/重播 + 是否显示罗马音 + 排序/乱序 -->
    <div class="score-bar">
      <el-tag type="success">正确 {{ correctCount }}</el-tag>
      <!-- 总数 - 正确数 = 错误数（因为本题要么对要么错，不扣分） -->
      <el-tag type="danger">错误 {{ totalCount - correctCount }}</el-tag>
      <el-button size="small" @click="reveal">答案</el-button>
      <!-- 跳过：不判分直接换题 -->
      <el-button size="small" @click="skip">跳过</el-button>
      <!-- 结束：停止并显示成绩汇总页 -->
      <el-button size="small" type="danger" plain @click="stopQuiz">结束</el-button>
      <!-- 重播：再读一遍当前题 -->
      <el-button size="small" @click="replayQuestion">🔊 重播</el-button>
      <!-- 显示罗马音的开关：淡一点的字显示在每个格子的假名下面 -->
      <span class="romaji-switch">
        <el-switch v-model="showRomaji" size="small" />
        <span>罗马音</span>
      </span>
      <!-- 排序/乱序：quizPool 在脚本里按这个重建 -->
      <el-radio-group v-model="gridOrder" size="small">
        <el-radio-button value="sorted">排序</el-radio-button>
        <el-radio-button value="shuffled">乱序</el-radio-button>
      </el-radio-group>
    </div>
    <!-- 选题九宫格：一张卡一个假名，点了触发 answer() -->
    <div class="quiz-grid" :class="{ 'grid-sorted': gridOrder === 'sorted' }">
      <div
          v-for="item in quizPool"
          :key="displayChar(item, script)"
          class="quiz-card"
          :class="[...(highlight[displayChar(item, script)] ? [highlight[displayChar(item, script)]] : [])]"
          @click="answer(item)">
        <div class="card-kana">{{ displayChar(item, script) }}</div>
        <div v-if="showRomaji" class="card-romaji">{{ item.romaji }}</div>
      </div>
    </div>
    <!-- 反馈条：revealed(主动点答案) 或 答过一题 时才出现；答错时额外显示"你选的 vs 正确答案" -->
    <div v-if="revealed || lastAnswer" class="reveal-tip" :class="{ 'reveal-wrong': lastAnswer && !lastAnswerCorrect }">
      <template v-if="revealed || lastAnswerCorrect">
        答案：<strong>{{ answeredChar }}</strong> ({{ currentRomaji }})
      </template>
      <template v-else>
        选了 <strong>{{ lastAnswerChar }}</strong> ({{ lastAnswerRomaji }})，正确 <strong>{{ answeredChar }}</strong> ({{ currentRomaji }})
      </template>
    </div>
  </div>

  <!-- ===== 结束/成绩页 ===== -->
  <div v-else class="panel center">
    <el-result icon="success" title="测验结束">
      <template #sub-title>
        正确 {{ correctCount }} / {{ totalCount }}
      </template>
    </el-result>
    <!-- 点"再来一次" → reset() → 再 emit("reset")，父页收到后退回设置区 -->
    <el-button type="primary" @click="reset">再来一次</el-button>
  </div>
</template>

<script setup lang="ts">
// ---------- 导入 ----------
import { computed, onUnmounted, ref, watch } from "vue";
// 工具：audioUrl(发音人, 假名) 拼音频路径；displayChar(假名对象, script) 取平/片文字；shuffle 洗牌
import { audioUrl, displayChar, shuffle } from "../utils/kana";
import type { KanaItem, Script } from "../utils/kana";
import type { KanaAnswer } from "../types";

// ---------- 组件接口 ----------
// props：pool=父页给的题目池，script=平/片，speaker=发音人下标
const props = defineProps<{ pool: KanaItem[]; script: Script; speaker: number }>();
// emit：只有一个自定义事件 "reset"，结束页"再来一次"时抛给父页，让父页回设置区
const emit = defineEmits<{
  (e: "reset"): void
  (e: "finished", results: KanaAnswer[]): void
}>();

// ---------- 答题状态（这轮会话内变的，全是内部状态） ----------
const running = ref(false);                                   // true=答题中 / false=结束页
const correctCount = ref(0);                                  // 答对数（正确 +1，跳过/没答不加）
const totalCount = ref(0);                                    // 已判分的题数（对或错都 +1）
const current = ref<KanaItem | null>(null);                   // 当前这道题是哪个假名对象（null=还没开始）
const quizPool = ref<KanaItem[]>([]);                         // 九宫格里显示的格子（排序 or 乱序，见 gridOrder）
const solved = ref(false);                                    // 本题是否已判分（防止同一题重复点两次过度计分）
const highlight = ref<Record<string, "correct" | "wrong">>({}); // 每个假名的高亮色，"correct"绿/"wrong"红
const revealed = ref(false);                                  // 是否主动点过"答案"（reveal 之后显示答案）
const answeredChar = ref("");                                 // 正确答案的字符（认错时反馈"+ 正确答案"）
const showRomaji = ref(false);                                // 格子里是否显示罗马音小字
const lastAnswer = ref<KanaItem | null>(null);                // 上一题你点的是哪个（供反馈条显示"你选了X"）
const lastAnswerCorrect = ref(false);                         // 上一题是否答对（决定反馈条红/绿）
const gridOrder = ref<"sorted" | "shuffled">("shuffled");     // 九宫格排序方式（默认乱序）
const results = ref<KanaAnswer[]>([]);
let audio: HTMLAudioElement | null = null;                    // 复用的 <audio> 实例（不每次都 new）
let timer: ReturnType<typeof setTimeout> | null = null;       // 判分后定时换下一题/清高亮的定时器句柄

// ---------- 反馈条用的派生值（current/lastAnswer 的格式化好读版） ----------
const currentRomaji = computed(() => current.value?.romaji ?? "");       // 当前题音标
const lastAnswerChar = computed(() => lastAnswer.value ? displayChar(lastAnswer.value, props.script) : ""); // 你点的字
const lastAnswerRomaji = computed(() => lastAnswer.value?.romaji ?? ""); // 你点的音标

// ---------- 开始（父页点"开始测验"会调用；defineExpose 把它暴露出去） ----------
function start() {
  if (!props.pool.length) return
  correctCount.value = 0
  totalCount.value = 0
  solved.value = false
  // 按 gridOrder 决定九宫格内容：sorted=原序副本 / shuffled=洗牌
  quizPool.value = gridOrder.value === "sorted" ? [...props.pool] : shuffle(props.pool)
  running.value = true
  results.value = []
  newQuestion()
}
// defineExpose：告诉父页"我这个组件对外只开放 start"；父页才能 .value?.start()
defineExpose({ start })

// ---------- 换题 ----------
function newQuestion() {
  const poolArr = props.pool
  if (poolArr.length === 0) return
  // 随机抽一题；尽量别连出同一个音标（guard 兜底最多重抽 10 次，池子大时基本不会连号）
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
  lastAnswer.value = null
  lastAnswerCorrect.value = false
  answeredChar.value = displayChar(next, props.script)
  highlight.value = {}
  playQuestion(next)          // 自动朗读本题
}

// 播放某题的读音（复用同一个 audio 对象，免去反复 new Audio）
function playQuestion(kana: KanaItem) {
  if (audio) {
    audio.src = audioUrl(props.speaker, kana.romaji)
    audio.play().catch(() => {})
  } else {
    audio = new Audio(audioUrl(props.speaker, kana.romaji))
    audio.play()
  }
}

// ---------- 点格子判分 ----------
function answer(item: KanaItem) {
  if (!running.value || !current.value || solved.value) return   // 已在判分状态则忽略重复点击
  const char = displayChar(item, props.script)                   // 点的字
  const answerChar = displayChar(current.value, props.script)    // 正确答案
  const isCorrect = item.romaji === current.value.romaji         // !!!判分核心：音标相同即算对（同音不同体也算）
  results.value.push({ itemKey: current.value.h, correct: isCorrect })
  solved.value = true
  lastAnswer.value = item
  lastAnswerCorrect.value = isCorrect
  revealed.value = false
  clearSchedule()
  if (isCorrect) {
    // 对：把点的格(以及可能不同写法的正确答案格)标绿，+1，1.2s 后自动下一题
    highlight.value = char === answerChar
      ? { [char]: "correct" }
      : { [char]: "correct", [answerChar]: "correct" }
    correctCount.value += 1
    totalCount.value += 1
    timer = setTimeout(newQuestion, 800)
  } else {
    // 错：点的格标红、正确格标绿，1.6s 后下一题（留久点看清对错）
    highlight.value = { [char]: "wrong", [answerChar]: "correct" }
    totalCount.value += 1
    timer = setTimeout(newQuestion, 2000)
  }
}

// ---------- 主动看答案（不判分） ----------
function reveal() {
  if (!running.value || !current.value) return
  revealed.value = true
  lastAnswer.value = null
  lastAnswerCorrect.value = false
  answeredChar.value = displayChar(current.value, props.script)
  highlight.value = { [answeredChar.value]: "correct" }
}

// ---------- 跳过（跳一题不计分，不占用 totalCount） ----------
function skip() {
  if (!running.value) return
  clearSchedule()
  newQuestion()
}

// 重播当前题读音
function replayQuestion() {
  if (running.value && current.value) playQuestion(current.value)
}

// ---------- 结束（停止会话） ----------
function stopQuiz() {
  clearSchedule()
  if (audio) audio.pause()
  running.value = false
  emit("finished", results.value)
}

// ---------- 结果页"再来一次"：复位并通知父页回设置区 ----------
function reset() {
  clearSchedule()
  if (audio) audio.pause()
  running.value = false
  emit("reset")
}

// 工具：清掉挂着的定时器（防止组件销毁/换题时旧回调再触发）
function clearSchedule() {
  if (timer) {
    clearTimeout(timer)
    timer = null
  }
}

// ---------- 观察者 ----------
// 答题中途切排序/乱序：把九宫格重建一份（正在答的这题不受影响）
watch(gridOrder, (order) => {
  if (!running.value) return
  quizPool.value = order === "sorted" ? [...props.pool] : shuffle(props.pool)
})

// 组件被销毁（如切到其他模式、页面关闭）时做清理：停定时器、停音频
onUnmounted(() => {
  clearSchedule()
  if (audio) audio.pause()
})
</script>

<style scoped>
.panel {
  background: var(--bg-card);
  border: 1px solid var(--border);
  border-radius: 10px;
  padding: 20px;
}

.panel.center {
  text-align: center;
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

.quiz-grid.grid-sorted {
  grid-template-columns: repeat(5, 1fr);
}

.quiz-card {
  border: 1px solid var(--border);
  border-radius: 8px;
  padding: 10px 4px;
  text-align: center;
  cursor: pointer;
  background: var(--bg-card);
  color: var(--text);
  transition: background 0.6s ease, border-color 0.6s ease, color 0.6s ease, transform 0.2s ease;
  user-select: none;
  touch-action: manipulation;
  -webkit-tap-highlight-color: transparent;
}

.card-kana {
  font-size: 26px;
  line-height: 1.3;
}

.card-romaji {
  font-size: 11px;
  color: var(--text-muted);
  line-height: 1.3;
  margin-top: 2px;
}

.romaji-switch {
  display: inline-flex;
  align-items: center;
  gap: 4px;
  font-size: 12px;
  color: var(--text-secondary);
}

@media (hover: hover) and (pointer: fine) {
  .quiz-card:hover {
    border-color: #afa9ec;
    background: #eeedfe;
  }
}

.quiz-card.correct {
  background: var(--correct-bg);
  border-color: var(--correct-border);
  color: var(--correct-text);
  animation: pop 0.25s ease;
}

.quiz-card.wrong {
  background: var(--wrong-bg);
  border-color: var(--wrong-border);
  color: var(--wrong-text);
  animation: pop 0.25s ease;
}

@keyframes pop {
  0% { transform: scale(1); }
  50% { transform: scale(1.12); }
  100% { transform: scale(1); }
}

.reveal-tip {
  margin-top: 14px;
  font-size: 18px;
  color: var(--text);
}

.reveal-tip.reveal-wrong {
  color: var(--wrong-text);
}
</style>