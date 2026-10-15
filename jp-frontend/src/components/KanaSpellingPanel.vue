<template>
  <!--
    KanaSpellingPanel = 拼写模式面板（听写页三个功能面板之一）
    玩法：屏幕上显示一个假名 → 你在输入框里打出它（默认要求打对应的假名，回车提交）
    → 严格相等判对错 → 对(绿)自动翻下一题，错(红)停在原地手动下一题 → 结束列出错题清单。
    注意：这个面板不发任何音，这是和测验/听写最大的区别。
    结构：running=true 答题中 / running=false 错题结果页。
  -->
  <!-- ===== 答题中 ===== -->
  <div v-if="running" class="panel center">
    <div class="progress-text">第 {{ index + 1 }} / {{ order.length }} 题</div>
    <!-- 题干：就一个大字假名（displayChar 按 script 显示平假名或片假名）。它既是题目也是答案 -->
    <transition name="kana">
    <div :key="index" class="spell-question">{{ displayChar(order[index], script ) }}</div>
      </transition>
    <div class="spell-row">
      <!-- @keydown.enter 是自己包的回车处理：要避开输入法候选态(IME)的"確定"回车，详见 onSpellEnter -->
      <el-input
          ref="spellInputRef"
          v-model="spellTyped"
          size="large"
          placeholder="输入对应的假名，回车提交"
          style="max-width: 260px"
          @compositionstart="onCompositionStart"
          @compositionend="onCompositionEnd"
          @keydown.enter="onSpellEnter" />
      <el-button type="primary" size="large" @click="spellSubmit">提交</el-button>
    </div>
    <!-- 反馈条：spellAnswered=true 才出现；对=绿的"正确！"，错=红的"你打了X，正确是Y" -->
    <div v-if="spellAnswered" class="spell-feedback" :class="spellOk ? 'ok' : 'err'">
      <template v-if="spellOk">正确！</template>
      <template v-else>
        你打了 <strong>{{ spellTyped.trim() || '（空）' }}</strong>，
        正确是 <strong>{{ displayChar(order[index], script) }}</strong> ({{ order[index].romaji }})
      </template>
    </div>

    <div class="btn-row">
      <el-button type="danger" plain @click="finishSpell">结束</el-button>
      <!-- 跳过：算进错题清单 -->
      <el-button @click="skipSpell">跳过</el-button>
      <!-- 下一题：只有提交过(spellAnswered=true)才可点，防止跳过没做的题 -->
      <el-button :disabled="!spellAnswered" @click="spellNext">下一题</el-button>

    </div>
  </div>

  <!-- ===== 结束：错题结果页 ===== -->
  <div v-else class="panel">
    <el-alert
        type="success"
        :closable="false"
        :title="spellWrongList.length === 0
          ? `全部正确！共 ${order.length} 题，全对 🎉`
          : `完成！答对 ${spellScore} 题，下面 ${spellWrongList.length} 个需要再练`" />
    <!-- 只列拼错的（+跳过的），全对就是空 list -->
    <div class="answer-list">
      <div v-for="(item, i) in spellWrongList" :key="i" class="answer-row">
        <span class="answer-kana">{{ displayChar(item, script) }}</span>
        <span class="answer-romaji">{{ item.romaji }}</span>
        <span class="answer-row-label">{{ groupLabelOf(item) }}</span>
      </div>
    </div>
    <div class="btn-row">
      <!-- 再来一轮 → reset() → emit("reset") 回设置区重新配 -->
      <el-button type="primary" @click="reset">再来一轮</el-button>
    </div>
  </div>
</template>

<script setup lang="ts">
// ---------- 导入 ----------
import { nextTick, onUnmounted, ref } from "vue";
import { ElInput } from "element-plus";
import { displayChar, groupLabelOf, shuffle } from "../utils/kana";
import type { KanaItem, Script } from "../utils/kana";

// ---------- 组件接口 ----------
// props：pool=题目池，script=平/片（决定题干显示平假名 or 片假名），count=拼多少题
const props = defineProps<{ pool: KanaItem[]; script: Script; count: number }>();
// emit：只有 "reset"，结果页"再来一轮"时通知父页回设置区
const emit = defineEmits<{ (e: "reset"): void }>();

// ---------- 会话状态 ----------
const running = ref(false);                          // true=答题中 / false=结果页
const order = ref<KanaItem[]>([]);                   // 本轮拼写顺序（开始前洗牌截断）
const index = ref(0);                                // 当前第几题
const spellTyped = ref("");                          // 输入框内容（v-model 双向绑定的值）
const spellAnswered = ref(false);                    // 本题是否已提交判分（"锁"：防重复/误触翻页）
const spellOk = ref(false);                          // 最近一次提交对不对（反馈条绿/红）
const spellScore = ref(0);                           // 累计答对数
const spellWrongList = ref<KanaItem[]>([]);          // 错题/跳过清单（结果页只列它）
const spellInputRef = ref<InstanceType<typeof ElInput> | null>(null); // 输入框组件实例，用来 .focus()
let composing: boolean = false;                      // 输入法是否处于"候选状态"（IME 关键，见下）
let timer: ReturnType<typeof setTimeout> | null = null; // 答对 0.8s 自动下一题的定时器

// ---------- 开始（父页调的入口） ----------
function start() {
  order.value = shuffle(props.pool).slice(0, props.count)  // 洗牌 取前某个 听写数量
  index.value = 0
  spellScore.value = 0
  spellWrongList.value = []
  spellTyped.value = ""
  spellAnswered.value = false
  spellOk.value = false
  running.value = true
  focusSpellInput()     // 进页面直接把光标放输入框
}

defineExpose({ start })

// 让输入框拿焦点（输入框是 v-if 刚渲染的，得等下一拍组件挂载完再 .focus()）
function focusSpellInput() {
  nextTick(() => spellInputRef.value?.focus())
}

// ---------- IME（输入法）协同：防止"確定候选"的回车被当成提交 ----------
// 打日文输入法时：敲 ka 屏幕上是 "ka"（未確定）→ 按 回车/空格 才变成 "か"（確定）
// 那个"確定"用的回车/空格会被 el-input 也收到 → 如果不拦，就会把候选态当提交。
// 机制：compositionstart/end 这俩事件标记此刻正在选字(iComposing=true)，
// 只有確定完成后(compositionend) composing 复位为 false，后面的回车才算真正的"提交"。
function onCompositionStart() {
  composing = true
}

function onCompositionEnd() {
  composing = false
}

// 回车统一入口：componsing 或事件自带的 isComposing 都说明还在选字 → 直接放行不提交；
// 否则：已提交过→这一下当"下一题"，没提交过→这一下当"提交"
function onSpellEnter(e: Event | KeyboardEvent) {
  if (composing) return
  if ((e as KeyboardEvent).isComposing) return
  if (spellAnswered.value) spellNext()
  else spellSubmit()
}

// ---------- 判分（你要改"罗马音答案"重点就在这里） ----------
function spellSubmit() {
  if (!running.value || spellAnswered.value) return        // 没在答题或已经判过，忽略
  // !!!当前判定核心：expect 是题干那个假名（displayChar），
  // 要改成"只打罗马音也算对"就在这行+下一行动手：
  //   const expect = displayChar(order.value[index.value], props.script)   → 换成 item.romaji
  //   并做 trim + toLowerCase() 忽略大小写（如 Se / SE 都算 se）
  const item = order.value[index.value]
  const kana = displayChar(item,props.script)
  //const expect = displayChar(order.value[index.value], props.script)
  const input = spellTyped.value.trim()                    // 去掉首尾空白（用户可能误打空格）
  const ok = input === kana || input.toLowerCase() === item.romaji.toLowerCase();
  spellAnswered.value = true                               // 上锁：本题不能再提交
  spellOk.value = ok
  if (ok) {
    spellScore.value += 1
    timer = setTimeout(() => spellNext(), 500)             // 答对 0.8s 后自动下一题
  } else {
    spellWrongList.value.push(order.value[index.value])    // 答错 → 记入错题清单（停留等手动）
  }
}

// 翻到下一题（答对的自动走这，答错的手动点）
function spellNext() {
  if (index.value + 1 >= order.value.length) {
    finishSpell()                                          // 最后一题答完 → 进结果页
    return
  }
  index.value += 1
  spellTyped.value = ""                                    // 清输入 + 解锁 + 复位反馈
  spellAnswered.value = false
  spellOk.value = false
  focusSpellInput()
}

// 跳过本（不算分但记一次错）然后前进，和 spellNext 一样的收尾
function skipSpell() {
  if (!running.value || spellAnswered.value) return
  spellWrongList.value.push(order.value[index.value])
  index.value += 1
  if (index.value >= order.value.length) {
    finishSpell()
    return
  }
  spellTyped.value = ""
  spellAnswered.value = false
  spellOk.value = false
  focusSpellInput()
}

// 收摊：清定时器 → running 归 false → 显示结果页
function finishSpell() {
  if (!running.value) return
  clearSchedule()
  running.value = false
}

// 结果页"再来一轮"：复位并通知父页回设置区（重新选行/数量）
function reset() {
  clearSchedule()
  running.value = false
  emit("reset")
}

// 工具：清掉挂着的定时器（答对后 0.8s 才翻页，若中途点了结束/离开要掐掉）
function clearSchedule() {
  if (timer) {
    clearTimeout(timer)
    timer = null
  }
}

// 组件被销毁时清理
onUnmounted(() => {
  clearSchedule()
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

.spell-question {
  font-size: 64px;
  font-weight: 500;
  color: var(--text);
  margin: 18px 0;
}

.spell-row {
  display: flex;
  justify-content: center;
  gap: 10px;
  margin: 8px 0;
}

.spell-feedback {
  margin-top: 12px;
  font-size: 16px;
}

.spell-feedback.ok {
  color: var(--correct-text);
}

.spell-feedback.err {
  color: var(--wrong-text);
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

.kana-enter-active {
  transition: opacity 0.3s ease, transform 0.3s ease;
}

.kana-enter-from {
  opacity: 0;
  transform: translateX(10px);
}

.kana-enter-to {
  opacity: 1;
  transform: translateX(0);
}
</style>