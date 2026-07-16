<template>
  <div>
    <!-- 复习提醒 -->
    <el-alert
        v-if="reviewCount > 0"
        :title="`今天有 ${reviewCount} 个词汇需要复习`"
        type="warning"
        show-icon
        :closable="false"
        style="margin-bottom: 20px;"
    >
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
          <div class="stat-value">{{ stats.total }}</div>
        </div>
      </el-col>
      <el-col :xs="12" :span="6">
        <div class="stat-card">
          <div class="stat-label">重点词汇</div>
          <div class="stat-value">{{ stats.important }}</div>
        </div>
      </el-col>
      <el-col :xs="12" :span="6">
        <div class="stat-card">
          <div class="stat-label">今日新增</div>
          <div class="stat-value">{{ stats.todayAdded }}</div>
        </div>
      </el-col>
      <el-col :xs="12" :span="6">
        <div class="stat-card">
          <div class="stat-label">待复习</div>
          <div class="stat-value">{{ reviewCount }}</div>
        </div>
      </el-col>
    </el-row>

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
import {getTodayReview, getVocabularyList} from "../api";

const loading = ref(false);
const list = ref<any[]>([])
const reviewCount = ref(0)

const recentList = computed(() => list.value.slice(0, 5))

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
    const [vocabRes, reviewRes]: any = await Promise.all([
      getVocabularyList(),
      getTodayReview()
    ])
    list.value = vocabRes.data
    reviewCount.value = reviewRes.data.totalCount
  } finally {
    loading.value = false
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
</style>