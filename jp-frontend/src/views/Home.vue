<template>
  <div>
    <!-- 复习提醒 -->
    <el-alert
        v-if="reviewCount > 0"
        type="warning"
        show-icon
        :closable="false"
        style="margin-bottom: 20px;"
    >
      <template #title>
        今天有 <CountUp :value="reviewCount" /> 个词汇需要复习
      </template>
      <template #default>
        <el-button size="small" type="warning" @click="$router.push('/review')">
          开始复习
        </el-button>
      </template>
    </el-alert>

    <!-- 统计卡片 -->
    <el-row :gutter="16" style="margin-bottom: 24px;">
      <el-col :xs="12" :span="6">
        <div class="stat-card">
          <div class="stat-label">总词汇量</div>
          <div class="stat-value"><CountUp :value="stats.total" /></div>
        </div>
      </el-col>
      <el-col :xs="12" :span="6">
        <div class="stat-card">
          <div class="stat-label">重点词汇</div>
          <div class="stat-value"><CountUp :value="stats.important" /></div>
        </div>
      </el-col>
      <el-col :xs="12" :span="6">
        <div class="stat-card">
          <div class="stat-label">今日新增</div>
          <div class="stat-value"><CountUp :value="stats.todayAdded" /></div>
        </div>
      </el-col>
      <el-col :xs="12" :span="6">
        <div class="stat-card">
          <div class="stat-label">待复习</div>
          <div class="stat-value"><CountUp :value="reviewCount" /></div>
        </div>
      </el-col>
    </el-row>

    <!-- 日常易错假名 -->
    <div class="weak-head">
      <div class="section-title" style="margin-bottom: 0;">易错假名 Top 10</div>
      <div class="weak-actions">
        <span class="archive-text">{{ lastArchiveText }}</span>
        <el-button
            style="margin-left: 10px;"
          size="small"
          type="warning"
          plain
          :loading="archiveLoading"
          @click="handleArchive">
          封存
        </el-button>
      </div>
    </div>

    <el-empty
        v-if="!loading && weakList.length === 0"
        :description="justArchived
        ? '本批次已封存，新答题会重新统计'
        : '答题满 3 次后才会出现在这里'"    />

    <el-table v-else :data="weakList" border stripe v-loading="loading" style="margin-bottom: 24px;">
      <el-table-column prop="itemKey" label="假名" width="90" />
      <el-table-column label="片假名" width="90">
        <template #default="{ row }">{{ katakanaOf(row.itemKey) }}</template>
      </el-table-column>
      <el-table-column label="罗马音" width="100">
        <template #default="{ row }">{{ romajiOf(row.itemKey) }}</template>
      </el-table-column>
      <el-table-column label="错误 / 总数" width="130">
        <template #default="{ row }">{{ row.wrongCount }} / {{ row.totalCount }}</template>
      </el-table-column>
      <el-table-column label="错误率" width="110">
        <template #default="{ row }">
          <el-tag :type="row.wrongRate >= 50 ? 'danger' : 'warning'" size="small">
            {{ formatRate(row.wrongRate) }}
          </el-tag>
        </template>
      </el-table-column>
    </el-table>

    <!-- 最近添加的词汇 -->
    <div class="section-title">最近添加的词汇</div>
    <el-table :data="recentList" border stripe v-loading="loading">
      <el-table-column prop="kana" label="假名" width="120" />
      <el-table-column prop="kanji" label="汉字" width="120" />
      <el-table-column prop="romaji" label="罗马字" width="120" />
      <el-table-column prop="meaning" label="中文" width="120" />
      <el-table-column label="英文" width="120">
        <template #default="{ row }">
          <span v-if="row.english">{{ row.english }}</span>
          <span v-else style="color: #ccc;">—</span>
        </template>
      </el-table-column>
      <el-table-column label="重点" width="70" align="center">
        <template #default="{ row }">
          <el-tag v-if="row.important === 1" type="danger" size="small">重点</el-tag>
        </template>
      </el-table-column>
    </el-table>
  </div>
</template>

<script setup lang="ts">

import {computed, onMounted, ref} from "vue";
import { flatten } from "../utils/kana";
import {
  getTodayReview,
  getVocabularyList,
  getWeakKana,
  getLastArchivedAt,
  archiveKanaLogs
} from "../api";
import CountUp from "../components/CountUp.vue";
import type { WeakKana } from "../types";
import {ElMessage, ElMessageBox} from "element-plus";

const loading = ref(false);
const list = ref<any[]>([])
const reviewCount = ref(0)

//key(平假名->片假名/罗马音)
const kanaMap = new Map(flatten().map(i => [i.h, i] as const))
const katakanaOf = (key: string) => kanaMap.get(key)?.k ?? ""
const romajiOf = (key: string) => kanaMap.get(key)?.romaji ?? ""
const formatRate = (rate: number) => `${Number(rate).toFixed(2)}%`
const lastArchiveText = computed(() =>
  lastArchivedAt.value ? `上次封存: ${lastArchivedAt.value.slice(0, 10)}` : "尚未封存"
)

// 假名易错状态
const weakList = ref<WeakKana[]>([])
const lastArchivedAt = ref<string | null>(null)
const recentList = computed(() => list.value.slice(0, 5))

const archiveLoading = ref(false)
const justArchived = ref(false)
const stats = computed(() => ({
  total: list.value.length,
  important: list.value.filter(v => v.important === 1).length,
      todayAdded: list.value.filter(v => {
        const today = new Date().toDateString()
        return new Date(v.createdAt).toDateString() === today
      }).length,
}))

const fetchData = async () => {
  loading.value = true
  try {
    const [vocabRes, reviewRes, weakRes, lastRes]: any = await Promise.all([
        getVocabularyList(),
        getTodayReview(),
        getWeakKana().catch(() => ({data: []})),
        getLastArchivedAt().catch(() => ({data: null}))
    ])
    list.value = vocabRes.data ?? []
    reviewCount.value = reviewRes.data.totalCount ?? 0
    weakList.value = weakRes.data ?? []
    lastArchivedAt.value = lastRes.data ?? null
  } catch (e) {
    console.error("home 数据加载失败", e)
  } finally {
    loading.value = false
  }
}

const handleArchive = async () => {
  try {
    await ElMessageBox.confirm("封存后当前错误率将清零,历史记录仍保存,确定封存吗?",
        "封存记录",
        {type: "warning", confirmButtonText: "封存", cancelButtonText: "取消"}
    )
  } catch (e) {
    return
  }

  archiveLoading.value = true
  try {
    await archiveKanaLogs()

    weakList.value = []

    const res: any = await getLastArchivedAt()
    lastArchivedAt.value = res.data ?? null

    justArchived.value = true
    ElMessage.success("已封存,统计重新开始")
  } catch (e) {
    console.error("封存失败", e)
  } finally {
    archiveLoading.value = false
  }
}
onMounted(fetchData)

</script>

<style scoped>
.stat-card {
  background: var(--toggle-bg);
  border-radius: 8px;
  padding: 16px;
  text-align: center;
}
.stat-label {
  font-size: 13px;
  color: var(--text-muted);
  margin-bottom: 8px;
}
.stat-value {
  font-size: 28px;
  font-weight: 500;
  color: var(--text);
}
.section-title {
  font-size: 15px;
  font-weight: 500;
  margin-bottom: 12px;
  color: var(--text);
}
.weak-head {
  display: flex;
  align-items: baseline;
  justify-content: space-between;
  margin-bottom: 12px;
}
.archive-text {
  font-size: 12px;
  color: var(--text-muted);
}
.weak-actions {
  display: flex;
  align-items: center;
  gap: 10px;
}
</style>