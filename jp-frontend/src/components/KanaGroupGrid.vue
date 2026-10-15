<template>
  <!--
    KanaGroupGrid = 选组面板（受控组件）
    受控：它自己"不存选择"。选中了哪些行是父页的 selectedGroups 决定的；
    它只负责 ①把父页传进来的 selectedGroups 画成高亮 ②点它 → emit 新数组回父页改。
    好处是父页是唯一数据源，改选、重置、读值都在一个地方。
  -->
  <!-- 快捷按钮行：一键把 selectedGroups 设置成对应集合 -->
  <div class="quick-row">
    <el-button size="small" @click="applyGroups(BASIC_LABELS)">基础</el-button>
    <el-button size="small" @click="applyGroups(DAKUON_LABELS)">浊音</el-button>
    <el-button size="small" @click="applyGroups(YOUON_LABELS)">拗音</el-button>
    <el-button size="small" @click="applyGroups(ALL_LABELS)">全选</el-button>
    <el-button size="small" @click="applyGroups([])">清空</el-button>
    <!-- props.xxx 在模板里必须写 props. 前缀（脚本里才可以直接裸写） -->
    <el-tag size="small" type="info" effect="plain">已选 {{ props.selectedGroups.length }} 个</el-tag>
  </div>
  <!-- 行列表：遍历 KANA_GROUPS 每行一块卡片 -->
  <div class="group-grid">
    <div
        v-for="group in KANA_GROUPS"
        :key="group.label"
        class="group-card"
        :class="{ active: isGroupSelected(group.label) }"
        @click="toggleGroup(group.label)">
      <!-- groupLabel 返回行的中文名（如"あ行"），并随着 script 切成 平/片 标题 -->
      <div class="group-label">{{ groupLabel(group, script) }}</div>
      <!-- 行里每个假名一张小图（按当前 script 显示平假名或片假名） -->
      <div class="group-kana">{{ group.items.map(i => displayChar(i, script)).join(' ') }}</div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { KANA_GROUPS, displayChar, groupLabel } from "../utils/kana"
import type { Script } from "../utils/kana"

// ---------- 组件接口（显式声明"我能收什么、能往外报什么"） ----------
// props（父页单向传进来的数据）：
//   selectedGroups  目前已勾选的行名数组
//   script          平假名 or 片假名（决定显示哪种字）
// 注意 props 是只读的，组件不能直接改它，只能按"规范途径"报告新值 → emit
const props = defineProps<{ selectedGroups: string[]; script: Script }>();
// emit（组件往外的"自定义事件"）：
//   "update:selectedGroups"  + 值 → 前端框架的约定写法，配合父页 v-model:selectedGroups 生效
// 即：v-model:selectedGroups 在父页 = :selectedGroups="x" @update:selectedGroups="v => x = v"
const emit = defineEmits<{ (e: "update:selectedGroups", v: string[]): void }>();

// ---------- 4 个快捷集合（按 26 行的位置切出来的静态常量） ----------
const ALL_LABELS = KANA_GROUPS.map(g => g.label);                 // 全部 26 行
const BASIC_LABELS = KANA_GROUPS.slice(0, 11).map(g => g.label);  // 前 11 行 = 清音
const DAKUON_LABELS = KANA_GROUPS.slice(11, 16).map(g => g.label);// 11~15 行 = 浊音
const YOUON_LABELS = KANA_GROUPS.slice(16).map(g => g.label);     // 16 行起 = 拗音

// 某个行是否被勾选（只读的纯判断，模板里用来上高亮 class）
const isGroupSelected = (label: string) => props.selectedGroups.includes(label);

// 点单个行的开关逻辑：
//   拷贝一份现有选择 → 已含则去掉（但保证至少留 1 个，防止全空没法开始）→ 没有则加上
//   最后不直接改自己，而是把新数组通过 emit 交还父页
function toggleGroup(label: string) {
  const next = [...props.selectedGroups];
  if (next.includes(label)) {
    if (next.length === 1) return;              // 只剩这一个时禁止取消
    next.splice(next.indexOf(label), 1);
  } else {
    next.push(label);
  }
  emit("update:selectedGroups", next);
}

// 快捷按钮：整体替换成传入的集合（清空传 []）
function applyGroups(labels: string[]) {
  emit("update:selectedGroups", labels);
}
</script>

<style scoped>
.quick-row {
  display: flex;
  align-items: center;
  flex-wrap: wrap;
  gap: 8px;
  margin-bottom: 12px;
}

.group-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(130px, 1fr));
  gap: 10px;
  margin-bottom: 16px;
}

.group-card {
  border: 1px solid var(--border);
  border-radius: 8px;
  padding: 10px 12px;
  cursor: pointer;
  transition: border-color 0.15s, background 0.15s;
  touch-action: manipulation;
  -webkit-tap-highlight-color: transparent;
}

.group-card.active {
  border-color: #534ab7;
  background: #fbfbff;
}

html.dark .group-card.active {
  background: var(--mode-active-bg);
}

@media (hover: hover) and (pointer: fine) {
  .group-card:hover {
    border-color: #534ab7;
  }
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
</style>