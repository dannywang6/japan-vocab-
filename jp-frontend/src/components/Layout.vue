<template>
  <el-container style="height: 100vh">
    <div v-if="showSidebar" class="mobile-overlay" @click="showSidebar = false" />
    <el-aside width="200px" :class="{ 'mobile-show': showSidebar }">
      <div class="logo" @click="goHome">🇯🇵 日语学习</div>
      <el-menu
        :default-active="route.path"
        router
        @select="showSidebar = false">
        <div class="nav-section">学习</div>
        <el-menu-item index="/vocabulary">
          <el-icon><Reading /></el-icon>词汇库
        </el-menu-item>
        <el-menu-item index="/practice">
          <el-icon><EditPen /></el-icon>练习
        </el-menu-item>
        <el-menu-item index="/dictation">
          <el-icon><Headset /></el-icon>假名听写
        </el-menu-item>
        <el-menu-item index="/review">
          <el-icon><Clock /></el-icon>复习计划
        </el-menu-item>
        <div class="nav-section">词汇</div>
        <el-menu-item index="/vocabulary/add">
          <el-icon><Plus /></el-icon>添加词汇
        </el-menu-item>
      </el-menu>
    </el-aside>
    <el-container>
      <el-header>
        <div class="header-left">
          <el-button v-if="isMobile" class="menu-btn" circle size="small" @click="showSidebar = true">
            <el-icon><Operation /></el-icon>
          </el-button>
          <span class="page-title">{{ pageTitle }}</span>
        </div>
        <div class="header-right">
          <el-tag type="primary">今日待复习 {{ todayCount }} 词</el-tag>
          <el-button :icon="isDark ? Moon : Sunny" circle size="small" @click="toggleDark" />
        </div>
      </el-header>
      <el-main>
        <slot />
      </el-main>
    </el-container>

  </el-container>
</template>


<script setup lang="ts">

import {computed, ref, onMounted, onUnmounted} from "vue";
import { useRoute } from "vue-router";
import { Moon, Sunny, Operation, Headset } from "@element-plus/icons-vue";
import { getTodayReview } from "../api";
import router from "../router";

const route = useRoute();

const isDark = ref(true)
const todayCount = ref(0)
const isMobile = ref(window.innerWidth < 768)
const showSidebar = ref(false)


async function fetchTodayCount() {
  try {
    const res: any = await getTodayReview()
    todayCount.value = res.data.totalCount ?? 0
  } catch {}
}
function onResize() {
  isMobile.value = window.innerWidth < 768
  if (!isMobile.value) showSidebar.value = false
}
function toggleDark() {
  isDark.value = !isDark.value
  document.documentElement.classList.toggle('dark', isDark.value)
  localStorage.setItem('dark-mode', String(isDark.value))
}

const pageTitle = computed(() => {
  const map: Record<string, string> = {
    '/': '首页',
    '/vocabulary': '词汇库',
    '/vocabulary/add': '添加词汇',
    '/practice': '练习',
    '/dictation': '假名听写',
    '/review': '复习计划',
  };
  return map[route.path] || '';
})

const goHome = () => {
  router.push('/')
  showSidebar.value = false
}
onMounted(() => {
  window.addEventListener('review-updated', fetchTodayCount)
  window.addEventListener('resize', onResize)
  isDark.value = localStorage.getItem('dark-mode') === 'true'
  document.documentElement.classList.toggle('dark', isDark.value)
  fetchTodayCount()
})

onUnmounted(() => {
  window.removeEventListener('resize', onResize)
  window.removeEventListener('review-updated', fetchTodayCount)
})
</script>

<style scoped>
.logo {
  padding: 16px;
  font-size: 16px;
  font-weight: 500;
  border-bottom: 1px solid var(--border-light);
  cursor: pointer;
  color: var(--text);
}
.nav-section {
  font-size: 11px;
  color: var(--text-muted);
  padding: 12px 16px 4px;
  text-transform: uppercase;
}
.el-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
}
.page-title {
  font-size: 16px;
  font-weight: 500;
}
.header-left {
  display: flex;
  align-items: center;
  gap: 8px;
}

@media (max-width: 768px) {
  .el-aside {
    position: fixed !important;
    left: -200px;
    top: 0;
    height: 100vh;
    z-index: 1000;
    transition: left 0.3s ease;
  }
  .el-aside.mobile-show {
    left: 0;
  }
  .mobile-overlay {
    position: fixed;
    inset: 0;
    background: rgba(0, 0, 0, 0.4);
    z-index: 999;
  }
}
</style>