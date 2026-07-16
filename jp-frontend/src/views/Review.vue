<template>
  <div class="review-page">
    <!-- 加载中 -->
    <el-skeleton v-if="loading" :rows="8" animated />

    <!-- 有题目 -->
    <template v-else-if="!finished && question">
      <div class="review-header">今日复习 {{ answer + 1 }} / {{ totalCount }}</div>

      <Transition name="fade-slide" mode="out-in">
        <div key="question" class="review-question-wrap">
          <div class="quiz-question">
            <div class="jp-kanji" v-if="question.correctKanji">{{ question.correctKanji }}</div>
            <div class="jp-kana">{{ question.correctKana }}</div>
            <div class="jp-romaji">{{ question.correctRomaji }}</div>
          <button class="sound-btn" @click="speak">🔊 发音</button>
          </div>

          <div class="quiz-options" :class="{ 'has-selected': selected }">
            <button v-for="opt in question.options" :key="opt.vocabId"
                    class="quiz-option" :class="optionClass(opt.vocabId)"
              @click="selectOption(opt.vocabId)">
              {{ opt.meaning }}
              </button>
          </div>
          <div class="next-row">
            <button class="next-btn" :disabled="selected === null" @click="nextQuestion">
              下一题 <span v-if="selected !== null"> (空格键) </span>
            </button>
          </div>
        </div>
      </Transition>
    </template>

    <template v-else-if="finished">
      <div class="complete-page">
        <div class="complete-icon">🎉</div>
        <div class="complete-title">今日复习全部完成</div>
        <div class="complete-score">正确 {{ score.correct }} / 错误 {{ score.wrong }}</div>
        <el-button type="primary" @click="$router.push('/')">返回首页</el-button>
      </div>
    </template>

    <!-- 暂无复习 -->
    <el-empty v-else description="今天没有待复习的词汇" />
  </div>
</template>

<script setup lang="ts">
import {onMounted, onUnmounted, ref} from "vue";
import {completeReview, getReviewQuestion, getTodayReview} from "../api";
import { initVoice, speakWord } from "../utils/speech";

const loading = ref(true)
const question = ref<any>(null)
const selected = ref<number | null>(null)
const totalCount = ref(0)
const answer = ref(0)
const score = ref({ correct: 0, wrong: 0 })
const finished = ref(false)

async function fetchTodayCount() {
  loading.value = true
  try {
    const res: any = await getTodayReview()
    totalCount.value = res.data.totalCount
    if (totalCount.value === 0) {
      loading.value = false
      return
    }
    await fetchQuestion()
  } catch (e) {
    console.error('获取复习数据失败:', e)
    loading.value = false
  }
}

async function fetchQuestion() {
  selected.value = null
  try {
    const res: any = await getReviewQuestion()
    if (res.data) {
      question.value = res.data
      speak()
    } else {
      finished.value = true
    }
  } catch (e) {
    console.error('获取复习题目失败:', e)
  } finally {
    loading.value = false
  }
}

function speak() {
  const t = question.value
  if (!t) return
  const text = t.correctKanji || t.correctKana || t.correctRomaji
  if (!text) return
  speakWord(text)
}

function optionClass(vocabId: number) {
  if (!selected.value) return
  if (vocabId === question.value.correctVocabId)  return 'correct'
  if (vocabId === selected.value) return 'wrong'
  return ''
}

async function selectOption(vocabId: number) {
  if (selected.value !== null) return
  selected.value = vocabId

  const isCorrect = vocabId === question.value.correctVocabId
  if (isCorrect) score.value.correct++
  else score.value.wrong++

  await completeReview(question.value.correctVocabId, isCorrect)

}

function nextQuestion() {
  if (selected.value === null) return
  answer.value ++
  if (answer.value >= totalCount.value) {
    finished.value = true
    window.dispatchEvent(new CustomEvent('review-updated'))

  } else {
    fetchQuestion()
  }
}

function handleKeydown(e: KeyboardEvent) {
  if (e.code ==='Space' && selected.value !== null && !finished.value) {
    e.preventDefault()
    nextQuestion()
  }
}

onMounted(() => {
  initVoice()
  fetchTodayCount()
  window.addEventListener('keydown', handleKeydown)
})
onUnmounted(() => window.removeEventListener('keydown', handleKeydown))
</script>

<style scoped>
.review-header {
  font-size: 15px;
  font-weight: 500;
  color: var(--text);
  margin-bottom: 20px;
  text-align: center;
}

.complete-page {
  text-align: center;
  padding: 60px 0;
}

.complete-icon {
  font-size: 56px;
  margin-bottom: 16px;
}

.complete-title {
  font-size: 22px;
  font-weight: 500;
  color: var(--text);
  margin-bottom: 12px;
}

.complete-score {
  font-size: 16px;
  color: var(--text-secondary);
  margin-bottom: 24px;
}

/* ---- 过渡动画 ---- */
.fade-slide-enter-active,
.fade-slide-leave-active {
  transition: opacity 0.25s ease, transform 0.25s ease;
}
.fade-slide-enter-from {
  opacity: 0;
  transform: translateY(12px);
}
.fade-slide-leave-to {
  opacity: 0;
  transform: translateY(-12px);
}

.quiz-options {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 10px;
}

.quiz-option {
  min-height: 50px;
  padding: 12px 14px;
  border: 1px solid var(--border);
  border-radius: 8px;
  font-size: 15px;
  cursor: pointer;
  background: var(--bg-card);
  color: var(--text);
  transition: all 0.15s;
}

.quiz-option:hover:not(.correct):not(.wrong) {
  background: #eeedfe;
  border-color: #afa9ec;
  color: #3c3489;
}

html.dark .quiz-option:hover:not(.correct):not(.wrong) {
  background: #3a3545;
  border-color: #7a74ac;
  color: #c0b8e8;
}

.has-selected .quiz-option:not(.correct):not(.wrong) {
  border-color: var(--border);
}

html.dark .has-selected .quiz-option:not(.correct):not(.wrong) {
  border-color: #6a6765;
}

.quiz-option.correct {
  background: #eaf3de;
  border-color: #97c459;
  color: #27500a;
}

html.dark .quiz-option.correct {
  background: var(--correct-bg);
  border-color: var(--correct-border);
  color: var(--correct-text);
}

.quiz-option.wrong {
  background: #fcebeb;
  border-color: #f09595;
  color: #791f1f;
}

html.dark .quiz-option.wrong {
  background: var(--wrong-bg);
  border-color: var(--wrong-border);
  color: var(--wrong-text);
}

.quiz-question {
  text-align: center;
  margin-bottom: 24px;
  padding-top: 16px;
}

.jp-kanji {
  font-size: 42px;
  font-weight: 500;
  color: var(--text);
  line-height: 1.3;
}

.jp-kana {
  font-size: 20px;
  color: var(--text-secondary);
  margin-top: 6px;
}

.jp-romaji {
  font-size: 14px;
  color: var(--text-muted);
  margin-top: 4px;
}

.sound-btn {
  margin-top: 12px;
  border: 1px solid var(--border);
  border-radius: 6px;
  padding: 4px 14px;
  background: var(--bg-card);
  cursor: pointer;
  font-size: 13px;
  color: var(--text-secondary);
  transition: background 0.15s;
}

.sound-btn:hover {
  background: var(--hover-bg);
}

.next-row {
  margin-top: 16px;
}

.next-btn {
  width: 100%;
  padding: 12px 0;
  border: 1px solid #534ab7;
  border-radius: 8px;
  background: #534ab7;
  color: #fff;
  font-size: 15px;
  cursor: pointer;
  transition: background 0.15s;
}

.next-btn:disabled {
  background: #c0c0c0;
  border-color: #c0c0c0;
  cursor: not-allowed;
  color: #fff;
}

.next-btn:not(:disabled):hover {
  background: #4239a0;
}

</style>
