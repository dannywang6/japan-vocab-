<template>
  <!--
    KanaDictationPanel = 听写模式面板
    玩法：每题朗读 2 遍（第1遍→停2秒→第2遍→停2秒→下一题），
    你拿纸笔写；全部播完展示"答案清单"对照批改。
    结构：running=true 播放中 / running=false 答案清单页。
  -->
  <!-- ===== 播放中 ===== -->
  <div v-if="running" class="panel center">
    <!-- 题目进度 -->
    <div class="progress-text">第 {{ index + 1 }} / {{ order.length }} 题</div>
    <!-- rep=1 第1遍(黄) / rep=2 第2遍(绿) -->
    <el-tag v-if="rep === 1" type="warning" effect="plain" style="margin-top: 10px">第 1 遍</el-tag>
    <el-tag v-else type="success" effect="plain" style="margin-top: 10px">第 2 遍</el-tag>
    <!-- 进度条：已放完的题数占比（除 max 防除零） -->
    <el-progress
        :percentage="Math.round(((index + 1) / Math.max(order.length, 1)) * 100)"
        :stroke-width="12"
        style="max-width: 480px; margin: 16px 0" />
    <!-- 播放中闪烁的小指示灯（由 playingNow 驱动） -->
    <div class="play-light" :class="{ on: playingNow }">🔊 播放中…</div>
    <div class="btn-row">
      <el-button @click="replayCurrent">🔁 重播本题</el-button>
      <!-- 中途整轮重播（回到第 1 题） -->
      <el-button @click="replayAll">重播全部</el-button>
      <!-- 中途停止 → stop() → emit("quit") 回设置区 -->
      <el-button type="danger" plain @click="stop">停止</el-button>
    </div>
  </div>

  <!-- ===== 播放完毕：答案清单 ===== -->
  <div v-else class="panel">
    <el-alert type="success" :closable="false" title="听写完毕，对照下面的顺序检查你写的答案吧" />
    <div class="answer-list">
      <!-- 记一题没 & 平假名/片假名 都列出来 & 音标 & 归哪一行 & 可单播 -->
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
      <!-- 重新听写 → reset() → emit("reset") 回设置区 -->
      <el-button type="primary" @click="reset">重新听写</el-button>
    </div>
  </div>
</template>

<script setup lang="ts">
import { onUnmounted, ref } from "vue";
import { audioUrl, groupLabelOf, shuffle } from "../utils/kana";
import type { KanaItem, Script } from "../utils/kana";
import { ElMessage } from "element-plus";

// ---------- 组件接口 ----------
// props：pool=题目池，script=平/片（这个面板里脚本几乎不用 script，答案清单平/片都显示）
//        speaker=发音人，count=要听写的题数（父页算好的 dictCount）
const props = defineProps<{ pool: KanaItem[]; script: Script; speaker: number; count: number }>();
// emit：两个事件，都能让父页回设置区，但含义略不同——
//   "quit"  用户中途按"停止"（主动放弃）
//   "reset" 听完后按"重新听写"（正常重来一次）
const emit = defineEmits<{ (e: "quit"): void; (e: "reset"): void }>();

// ---------- 会话状态 ----------
const running = ref(false);                    // true=播放中 / false=展示答案清单
const order = ref<KanaItem[]>([]);             // 本轮听写顺序（开跑前洗牌，跑完不换，答案清单照它列）
const index = ref(0);                          // 当前播到第几题（0 起）
const rep = ref(1);                            // 当前这题第几遍（1 或 2），模板用来显示"第1遍/第2遍"
const playingNow = ref(false);                 // 是否正在出声（闪烁灯 + 音频兜底提示）
let audio: HTMLAudioElement | null = null;     // 复用的 audio 实例
let timer: ReturnType<typeof setTimeout> | null = null; // 串联"第1遍→2s→第2遍→2s→下一题"的定时器

// ---------- 开始（父页调） ----------
function start() {
  order.value = shuffle(props.pool).slice(0, props.count)   // 洗牌 + 掐够 count 题
  index.value = 0
  running.value = true
  play(order.value[0])
}
defineExpose({ start })

// ---------- 核心：一道题的"双读 + 延时接下一题"编排 ----------
function play(kana: KanaItem) {
  rep.value = 1
  playOnce(kana)                                             // ①先读第 1 遍
  clearSchedule()                                            // 清掉上一题遗留的定时器
  timer = setTimeout(() => {                                 // ②等 2 秒
    if (!running.value) return                               //    用户中途按了停止就别继续
    rep.value = 2
    playOnce(kana)                                           // ③读第 2 遍
    clearSchedule()
    timer = setTimeout(() => {                               // ④再等 2 秒
      if (running.value) nextInDictation()                   // ⑤换下一题
    }, 2000)
  }, 2000)
}

// 真正发声的那一下（并维护播放指示灯）
function playOnce(kana: KanaItem) {
  playingNow.value = true
  if (audio) {
    audio.src = audioUrl(props.speaker, kana.romaji)
    audio.play().catch(() => {
      ElMessage.warning("音频播放被浏览器拦截，请先点击页面任意位置")  // 自动播放被拦时提示怼一下
      playingNow.value = false
    })
  } else {
    audio = new Audio(audioUrl(props.speaker, kana.romaji))
    audio.play()
  }
}

// 工具：清掉挂着的定时器
function clearSchedule() {
  if (timer) {
    clearTimeout(timer)
    timer = null
  }
}

// 播完当前题后：进下一题，或到末尾收起 list
function nextInDictation() {
  index.value += 1
  if (index.value >= order.value.length) {
    playingNow.value = false
    running.value = false          // 播完 → 切到答案清单页
    return
  }
  play(order.value[index.value])
}

// 中途"重播本题"：从第 1 遍重新放当前题
function replayCurrent() {
  if (order.value[index.value]) play(order.value[index.value])
}

// "重播全部"（播放中或清单页都可点）：回到第 1 题整轮重放
function replayAll() {
  if (order.value.length === 0) return
  index.value = 0
  running.value = true
  play(order.value[0])
}

// 清单页里"🔊"：单独播某个条目一遍（不接下一题）
function replayItem(item: KanaItem) {
  playOnce(item)
}

// ---------- 停止 vs 重置（都收摊，只是通知父页的事件名不同） ----------
function stop() {                       // 中途主动放弃
  clearSchedule()
  if (audio) audio.pause()
  playingNow.value = false
  running.value = false
  emit("quit")
}

function reset() {                      // 听完后重新来
  clearSchedule()
  if (audio) audio.pause()
  playingNow.value = false
  running.value = false
  emit("reset")
}

// 组件销毁时清理（防组件没了定时器还响）
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