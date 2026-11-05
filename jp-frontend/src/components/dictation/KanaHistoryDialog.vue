<template>
  <!--
    历史易错弹窗（挂在 /dictation 页面，由父组件的 v-model 控制显隐）
    整体逻辑：打开 -> 查一次“统计范围” -> 默认查全部历史 -> 用户可切到自定义区间
  -->
  <el-dialog
      v-model="visible"
      title="历史易错统计"
      width="720px"
      append-to-body
      @open="handleOpen">
    <!-- v-loading：查“统计范围”期间在这块区域盖一层转圈遮罩 -->
    <div v-loading="rangeLoading" class="history-body">
      <!-- 情况一：一条封存记录都没有（firstAnsweredAt / lastArchivedAt 都是 null） -->
      <el-alert
          v-if="!rangeLoading && !hasArchive"
          type="info"
          :closable="false"
          show-icon
          title="还没有封存记录"
          description="先在首页点一次“封存”，之后就能在这里按日期查看历史错误率。" />

      <!-- 情况二：有历史数据，显示查询控件 + 表格 -->
      <template v-else-if="hasArchive">
        <div class="history-toolbar">
          <!-- 两种口径：all=全部历史（锁定范围）；custom=用户自己选日期 -->
          <el-radio-group v-model="scope" size="small" @change="onScopeChange">
            <el-radio-button value="all">全部历史</el-radio-button>
            <el-radio-button value="custom">自定义区间</el-radio-button>
          </el-radio-group>

          <!-- 只有切到“自定义区间”才出现日期选择器 -->
          <el-date-picker
              v-if="scope === 'custom'"
              v-model="range"
              type="daterange"
              value-format="YYYY-MM-DD"
              range-separator="至"
              start-placeholder="开始日期"
              end-placeholder="结束日期"
              :disabled-date="disabledDate"
              :shortcuts="shortcuts"
              unlink-panels
              size="small"
              style="width: 320px"
              @change="load" />
        </div>

        <!-- 说明统计口径：只算已封存数据，日期上限是上次封存日 -->
        <p class="history-note">
          仅统计已封存的答题记录，最晚可选 {{ endText }}；同一假名答满 3 次才会上榜。
        </p>

        <el-table :data="list" border stripe v-loading="loading" max-height="420">
          <!-- 第一列直接显示后端返回的 itemKey（平假名） -->
          <el-table-column prop="itemKey" label="假名" width="80" />
          <!-- 片假名不由后端返回，前端用 kanaMap 查出来 -->
          <el-table-column label="片假名" width="80">
            <template #default="{ row }">{{ katakanaOf(row.itemKey) }}</template>
          </el-table-column>
          <!-- 罗马音同理，前端映射 -->
          <el-table-column label="罗马音" width="90">
            <template #default="{ row }">{{ romajiOf(row.itemKey) }}</template>
          </el-table-column>
          <!-- 错误次数 / 总答题次数 -->
          <el-table-column label="错误 / 总数" width="110">
            <template #default="{ row }">{{ row.wrongCount }} / {{ row.totalCount }}</template>
          </el-table-column>
          <el-table-column label="错误率" min-width="160">
            <template #default="{ row }">
              <div class="rate-cell">
                <!--
                  注意：percentage 绑的是 rates[row.itemKey]，不是 row.wrongRate。
                  rates 先被置 0，再在下一帧改成真实值，这样进度条才有“从 0 涨上去”的动画。
                -->
                <el-progress
                    :percentage="rates[row.itemKey] ?? 0"
                    :stroke-width="8"
                    :color="rateColor(row.wrongRate)"
                    :show-text="false"
                    class="rate-bar" />
                <!-- 右侧文字始终显示真实错误率，不受动画影响 -->
                <span class="rate-text">{{ formatRate(row.wrongRate) }}</span>
              </div>
            </template>
          </el-table-column>

          <!-- 空状态：文案由 emptyText 根据当前场景动态给出 -->
          <template #empty>
            <span class="history-empty">{{ emptyText }}</span>
          </template>
        </el-table>

        <!-- 汇总行：用“总错误数 / 总答题数”算加权平均，避免各行错误率简单平均造成偏差 -->
        <div v-if="list.length" class="history-summary">
          共 {{ list.length }} 个假名 · 加权平均错误率 {{ avgRate }}%
        </div>
      </template>
    </div>

    <template #footer>
      <el-button @click="visible = false">关闭</el-button>
    </template>
  </el-dialog>
</template>

<script setup lang="ts">
import {computed, ref, nextTick} from "vue";
import {getKanaHistoryRange, getWeakKanaHistory} from "../../api";
import type {KanaHistoryRange, WeakKana} from "../../types";
import {flatten} from "../../utils/kana";

// 父组件用 v-model="historyVisible" 控制显隐，这里对应一个可读写的 visible
const visible = defineModel<boolean>({default: false});

// ---------- 状态 ----------
// 查“统计范围”时的 loading（弹窗刚打开那一下）
const rangeLoading = ref(false);
// 查“易错榜”时的 loading（表格上的转圈）
const loading = ref(false);
// 当前口径：all=全部历史 / custom=自定义区间
const scope = ref<"all" | "custom">("all");
// 日期区间，格式 ["2026-10-21", "2026-11-02"]；null 表示还没选
const range = ref<[string, string] | null>(null);
// 表格数据
const list = ref<WeakKana[]>([]);
// 统计范围：最早答题时间 + 最近封存时间（来自 /history/range）
const meta = ref<KanaHistoryRange | null>(null);
// 是否已经真正查过一次，用来区分“暂无数据”和“还没查”
const queried = ref(false);
// 进度条动画用的“当前显示百分比”：key 是假名，value 是此刻要显示的百分比
const rates = ref<Record<string, number>>({});

// ---------- 计算属性 ----------
// 只有两个时间都有值，才算“封存过”。这样后面用 ! 断言才安全
const hasArchive = computed(() =>
    !!meta.value?.firstAnsweredAt && !!meta.value?.lastArchivedAt);
// 日期选择器的最晚可选日（把 ISO 时间截成 YYYY-MM-DD）
const endText = computed(() =>
    meta.value?.lastArchivedAt ? meta.value.lastArchivedAt.slice(0, 10) : "");

// 表格空状态文案，按优先级依次判断
const emptyText = computed(() => {
  // 切到自定义但还没选日期
  if (scope.value === "custom" && !range.value) return "选择日期区间后显示结果";
  // 还没发起过查询
  if (!queried.value) return "暂无数据";
  // 查过了，但过滤后没有假名达标（不足 3 次）
  return "该区间内没有假名答满 3 次";
});

// 加权平均错误率 = 总错误数 / 总答题数，而不是各条错误率的平均
const avgRate = computed(() => {
  const total = list.value.reduce((s, i) => s + i.totalCount, 0);
  const wrong = list.value.reduce((s, i) => s + i.wrongCount, 0);
  return total ? ((wrong / total) * 100).toFixed(2) : "0.00";
});

// ---------- 假名映射工具 ----------
// flatten() 返回所有假名条目，这里建成 Map：平假名 -> 条目
const kanaMap = new Map(flatten().map(i => [i.h, i] as const));
// 平假名找片假名，查不到返回空字符串（不会渲染成 undefined）
const katakanaOf = (key: string) => kanaMap.get(key)?.k ?? "";
// 平假名找罗马音
const romajiOf = (key: string) => kanaMap.get(key)?.romaji ?? "";
// 统一保留两位小数
const formatRate = (rate: number) => `${Number(rate).toFixed(2)}%`;
// 按错误率给进度条上色：>=50 红 / >=25 橙 / 其余绿
const rateColor = (rate: number) =>
    rate >= 50 ? "#f56c6c" : rate >= 25 ? "#e6a23c" : "#67c23a";

// ---------- 打开弹窗 ----------
// 每次打开都重新拉一次范围，保证“上次封存日”是最新的（首页可能刚封存过）
const handleOpen = async () => {
  rangeLoading.value = true;
  try {
    // ① 查统计范围：最早答题时间 ~ 最近封存时间
    const res: any = await getKanaHistoryRange();
    meta.value = res.data ?? null;
    // 先清空旧结果，避免闪一下上个区间的数据
    list.value = [];
    queried.value = false;
    // 没封存过就没得查，直接显示空状态提示
    if (!hasArchive.value) return;

    // ② 有数据：默认切到“全部历史”，并把区间设成整个范围
    scope.value = "all";
    range.value = [
      meta.value!.firstAnsweredAt!.slice(0, 10),   // ISO 时间截成 YYYY-MM-DD
      meta.value!.lastArchivedAt!.slice(0, 10)
    ];
    // ③ 用这个区间查易错榜
    await load();
  } finally {
    rangeLoading.value = false;
  }
};

// ---------- 查询易错榜 ----------
// 所有查询入口（打开弹窗 / 选日期 / 切回全部）最终都走这里
const load = async () => {
  // 没有区间（刚切到自定义还没选）就不发请求
  if (!range.value) {
    list.value = [];
    queried.value = false;
    return;
  }
  const [startDate, endDate] = range.value;
  loading.value = true;
  try {
    const res: any = await getWeakKanaHistory(startDate, endDate);
    list.value = res.data ?? [];
    queried.value = true;
    // 数据换了就重新播一次进度条动画
    playBars();
  } finally {
    loading.value = false;
  }
};

// ---------- 切换“全部 / 自定义” ----------
const onScopeChange = () => {
  if (scope.value === "all") {
    // 切回全部：区间重置成整个历史范围，立刻重查
    range.value = [
      meta.value!.firstAnsweredAt!.slice(0, 10),
      meta.value!.lastArchivedAt!.slice(0, 10)
    ];
    load();
  } else {
    // 切到自定义：清空日期和表格，等用户自己选（选了才查）
    range.value = null;
    list.value = [];
    queried.value = false;
  }
};

// ---------- 日期选择限制 ----------
// 封存之后的日期没有统计意义（is_archived 还是 0），一律禁选
const disabledDate = (date: Date) => {
  if (!meta.value?.lastArchivedAt) return true;
  return date.getTime() > new Date(meta.value.lastArchivedAt).getTime();
};

// 以“上次封存日”为终点，往前推 n 天，返回 [开始, 结束]
const lastNDays = (n: number): [Date, Date] => {
  const end = new Date(meta.value!.lastArchivedAt!);
  const start = new Date(end);
  start.setDate(start.getDate() - (n - 1));   // 含今天，所以是 n-1
  return [start, end];
};

// 日期选择器左侧的快捷选项
const shortcuts = [
  {text: "最近 7 天", value: () => lastNDays(7)},
  {text: "最近 30 天", value: () => lastNDays(30)},
  {text: "最近 90 天", value: () => lastNDays(90)},
  {
    text: "全部",
    value: () => [
      new Date(meta.value!.firstAnsweredAt!),
      new Date(meta.value!.lastArchivedAt!)
    ]
  }
];

// ---------- 进度条动画 ----------
// 思路：先把所有进度条渲染成 0，等浏览器真的画出来，再改成真实值，
// Element Plus 自带的 transition: width .6s 就会把中间过程变成动画。
const playBars = async () => {
  // ① 全部先归零
  const zero: Record<string, number> = {};
  list.value.forEach(i => { zero[i.itemKey] = 0; });
  rates.value = zero;

  // ② 等 Vue 把“0”渲染到 DOM
  await nextTick();

  // ③ 下一帧再改成真实错误率，transition 自动接管
  //    60ms 是为了给浏览器一帧时间：如果同步改回真实值，0 还没画出来就被覆盖，看不到动画
  setTimeout(() => {
    const target: Record<string, number> = {};
    list.value.forEach(i => { target[i.itemKey] = Number(i.wrongRate); });
    rates.value = target;
  }, 60);
};
</script>

<style scoped>
/* 给弹窗内容一个最小高度，避免刚打开时高度跳动 */
.history-body {
  min-height: 180px;
}
/* 顶部工具行：单选组 + 日期选择器，窄屏自动换行 */
.history-toolbar {
  display: flex;
  align-items: center;
  flex-wrap: wrap;
  gap: 12px;
  margin-bottom: 10px;
}
/* 统计口径说明 */
.history-note {
  font-size: 12px;
  color: var(--text-muted);
  margin: 0 0 12px;
}
/* 错误率单元格：进度条 + 数字，横向排列 */
.rate-cell {
  display: flex;
  align-items: center;
  gap: 8px;
}
/* 进度条占满剩余空间 */
.rate-bar {
  flex: 1;
}
/* 右侧固定宽度的数字，保证各行对齐 */
.rate-text {
  width: 56px;
  font-size: 12px;
  color: var(--text-muted);
  text-align: right;
}
/* 底部汇总行，右对齐 */
.history-summary {
  margin-top: 10px;
  font-size: 12px;
  color: var(--text-muted);
  text-align: right;
}
/* 表格空状态文字 */
.history-empty {
  font-size: 13px;
  color: var(--text-muted);
}
</style>
