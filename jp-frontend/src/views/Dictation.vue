<template>
  <!--
    听写主页 = 总调度。它本身不含任何游戏逻辑，只做三件事：
      1. 顶部模式切换（测验/听写/拼写）+ 平假名/片假名切换
      2. 会话没开始时 → 显示"设置区"（选行、数量、发音人、开始按钮）
      3. 点"开始"后 → sessionActive 翻成 true，按当前模式渲染对应的那个子面板
    核心是 sessionActive 这把"锁"：false = 设置区 / true = 面板区，
    两个分区靠 v-if / v-else-if / v-else 互斥显示。
  -->
  <div class="dictation-page">
    <div class="mode-switch">
      <!-- mode = 选功能（决定渲染哪个面板）；script = 选平/片（传给子面板决定显示哪种字） -->
      <el-radio-group v-model="mode" size="large">
        <el-radio-button value="quiz">测验模式</el-radio-button>
        <el-radio-button value="dictation">听写模式</el-radio-button>
        <el-radio-button value="spelling">拼写模式</el-radio-button>
      </el-radio-group>
      <el-radio-group v-model="script" size="large" style="margin-left: 12px">
        <el-radio-button value="hiragana">平假名</el-radio-button>
        <el-radio-button value="katakana">片假名</el-radio-button>
      </el-radio-group>
    </div>

    <!-- 设置区：会话没开始时显示。从上到下：选行 → 数量（仅听写/拼写）→ 发音人（拼写不显示）→ 开始按钮 -->
    <div v-if="!sessionActive" class="panel">
      <div class="section-title">选择要听写的假名（可按行多选）</div>
      <!-- 选组组件：v-model:selectedGroups 是"双向绑定"简写 = :selectedGroups + @update:selectedGroups 两个绑定 -->
      <!-- 子组件不自己存选择，点它 → 它 emit 新数组 → 这里改 selectedGroups → 回传显示，这就是"受控组件" -->
      <KanaGroupGrid v-model:selectedGroups="selectedGroups" :script="script" />

      <!-- 数量选择：quiz 模式下一次出一道题、不限制总题数，所以只有 dictation/spelling 才显示 -->
      <div v-if="mode === 'dictation' || mode === 'spelling'" class="row">
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

      <!-- 发音人：挑谁来读音频。拼写模式不打字（不发音），所以拼写时不显示这行 -->
      <div v-if="mode !== 'spelling'" class="row">
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
        {{ startLabel }}
      </el-button>
      <!-- pool 为空 = 一行都没勾，按钮禁用并给提示 -->
      <el-alert
          v-if="pool.length === 0"
          type="warning"
          :closable="false"
          title="请至少选择一行的假名"
          style="margin-top: 12px" />
    </div>

    <!-- 三个功能面板按模式切换：每次只渲染一个。父页把题目池和设置通过 props 传给对应面板 -->
    <!-- 测验面板：传 题目池/平片/发音人；监听 @reset（用户点"再来一次"）→ 回设置区 -->
    <KanaQuizPanel v-else-if="mode === 'quiz'" ref="quizPanel"
        :pool="pool" :script="script" :speaker="speaker"
        @reset="sessionActive = false" />
    <!-- 听写面板：多传一个题数 dictCount；@quit=中途按"停止"，@reset=听完后按"重新听写" -->
    <KanaDictationPanel v-else-if="mode === 'dictation'" ref="dictPanel"
        :pool="pool" :script="script" :speaker="speaker" :count="dictCount"
        @quit="sessionActive = false" @reset="sessionActive = false" />
    <!-- 拼写面板：纯打字不发音，所以没有 speaker -->
    <KanaSpellingPanel v-else ref="spellPanel"
        :pool="pool" :script="script" :count="dictCount"
        @reset="sessionActive = false" />
  </div>
</template>

<script setup lang="ts">
// ---------- 导入 ----------
import { computed, nextTick, ref, watch } from "vue";
// KANA_GROUPS = 26 个"行"的常量数组（每行含平/片/音标/行名），SPEAKERS = 可选发音人
import { KANA_GROUPS, SPEAKERS } from "../utils/kana";
// Script 是 "hiragana" | "katakana" 的字面量联合类型，保证 script 只能这两个值之一
import type { Script } from "../utils/kana";
// 三个功能面板 + 选组组件
import KanaGroupGrid from "../components/KanaGroupGrid.vue";
import KanaQuizPanel from "../components/KanaQuizPanel.vue";
import KanaDictationPanel from "../components/KanaDictationPanel.vue";
import KanaSpellingPanel from "../components/KanaSpellingPanel.vue";

// mode 只允许这三个值，模板里用 v-else-if / v-else 逐一对应到某个面板
type Mode = "quiz" | "dictation" | "spelling";

// ---------- 用户设置（设置区改的全是这几个 ref） ----------
// 当前功能模式：测验 / 听写 / 拼写
const mode = ref<Mode>("quiz");
// 平假名 or 片假名：决定子面板用平假名显示还是片假名显示
const script = ref<Script>("hiragana");
// 发音人下标（对应 SPEAKERS 数组的 id）。听写/测验用，拼写不发音用不到
const speaker = ref(0);
// 已勾选的行名（如 ["あ行","か行"]）。v-model:selectedGroups 和 KanaGroupGrid 双向同步
const selectedGroups = ref<string[]>(KANA_GROUPS.slice(0, 11).map(g => g.label));
// 数量档位：all / 5 / 10 / 15 / 20 / custom
const countSel = ref<string>("all");
// 选 custom 档时手动输入的数量
const customCount = ref(5);
// 会话锁：false=显示设置区 / true=已点开始、显示对应面板。切模式/平片会把它砸回 false
const sessionActive = ref(false);

// ---------- 三个面板的"遥控器"引用 ----------
// InstanceType<typeof 组件> = 该组件实例的类型（也算教学点：模板 ref 拿到的就是实例对象）
// 因为面板是 v-if 条件渲染的，组件挂载前这个引用是 undefined，所以类型带 ?（可能为空），
// 调用方法时要写 .value?.xxx() 做空值保护
const quizPanel = ref<InstanceType<typeof KanaQuizPanel>>();
const dictPanel = ref<InstanceType<typeof KanaDictationPanel>>();
const spellPanel = ref<InstanceType<typeof KanaSpellingPanel>>();

// ---------- 计算属性（不存新状态，由上面的设置推导） ----------
// 题目池：把已勾选各行的 items 全部摊平成一个一维数组
const pool = computed(() =>
  KANA_GROUPS.filter(g => selectedGroups.value.includes(g.label))
    .flatMap(g => g.items)
)

// 池子大小 = "全部"那一档显示的数字
const maxCount = computed(() => pool.value.length)

// 最终听写/拼写的题数：custom 用输入值；其他档用 Math.min 夹住，
// 避免数量比池子还大（例如只剩 3 个可练却选了 10）
const dictCount = computed(() =>
  countSel.value === "custom"
    ? Math.min(customCount.value, maxCount.value)
    : countSel.value === "all"
      ? maxCount.value
      : Math.min(Number(countSel.value), maxCount.value)
)

// 开始按钮文案随模式变化
const startLabel = computed(() =>
  mode.value === "dictation" ? "开始听写"
    : mode.value === "spelling" ? "开始拼写"
      : "开始测验")

// ---------- 开始 ----------
// 流程三步：①锁上设置区 ②面板是 v-if 刚渲染的，必须 await nextTick() 等它占好一位，
// ref 才能拿到实例；否则此时 panelRef.value 还是 undefined ③按模式调对应面板的 start()
async function start() {
  if (pool.value.length === 0) return            // 一行都没勾，不开始
  sessionActive.value = true
  await nextTick()
  if (mode.value === "quiz") quizPanel.value?.start()
  else if (mode.value === "dictation") dictPanel.value?.start()
  else spellPanel.value?.start()
}

// 用户在中途切换 mode 或 script → 强制回设置区，让新选择从头生效
watch([mode, script], () => { sessionActive.value = false })

// 选组变化后，若正用"自定义数量"且手输值超了新池子，钳制到池子上限
watch(selectedGroups, () => {
  if (countSel.value === 'custom' && customCount.value > maxCount.value) {
    customCount.value = maxCount.value
  }
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

.section-title {
  font-size: 15px;
  font-weight: 500;
  color: var(--text);
  margin-bottom: 12px;
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
</style>