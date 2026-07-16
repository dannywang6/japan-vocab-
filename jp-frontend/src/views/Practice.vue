<template>
  <div class="practice-page">
    <!-- 模式选择：选中后折叠 -->
    <div class="mode-grid" v-if="!modeChosen">
      <div class="mode-card"
            @click="switchType('jp_to_cn')"
      >
        <div class="mode-icon jp-icon">日</div>
        <div class="mode-title">日→中</div>
        <div class="mode-desc">看日语，选出正确中文</div>
      </div>
      <div class="mode-card"
            @click="switchType('cn_to_jp')">
        <div class="mode-icon cn-icon">中</div>
        <div class="mode-title">中→日</div>
        <div class="mode-desc">看中文，选出正确日语</div>
      </div>
    </div>

    <!-- 已选模式指示器 -->
    <div class="mode-indicator" v-else>
      <span class="mode-pill">{{ quizType === 'jp_to_cn' ? '日→中' : '中→日' }}</span>
      <span class="mode-hint">点击"下一题"继续，空格键快速翻题</span>
    </div>

    <template v-if="modeChosen">
      <el-empty v-if="!firstLoad && !loading && !question" description="暂无题目">
        <el-button type="primary" @click="fetchQuestion">重新出题</el-button>
      </el-empty>
      <el-skeleton v-if="firstLoad && loading" :rows="8" animated />

      <Transition v-if="question" name="fade-slide" mode="out-in">
      <div key="question" class="question-wrap">
        <div class="quiz-question">
          <template v-if="quizType === 'jp_to_cn'">
            <div class="jp-kanji" v-if="question.correctKanji">{{ question.correctKanji}}</div>
            <div class="jp-kana">{{ question.correctKana }}</div>
            <div class="jp-romaji">{{ question.correctRomaji }}</div>
          </template>
          <div v-else class="cn-text">{{ question.correctMeaning }}</div>
          <button class="sound-btn" @click="speak">🔊 发音</button>
        </div>
        <div class="quiz-options" :class="{ 'has-selected': selected }">
          <button v-for="opt in question.options" :key="opt.vocabId"
           class="quiz-option" :class="optionClass(opt.vocabId)"
           @click="selectOption(opt.vocabId)">
            <template v-if="quizType === 'jp_to_cn'">{{ opt.meaning }}</template>
            <template v-else>
              <div class="opt-kanji" v-if="opt.kanji">{{ opt.kanji }}</div>
              <div class="opt-kana">{{ opt.kana }}</div>
              <div class="opt-romaji">{{ opt.romaji }}</div>
              </template>
          </button>
        </div>

        <div class="next-row">
          <button class="next-btn" :disabled="selected === null"  @click="nextQuestion">
            下一题<span v-if="selected !== null"> (空格键) </span>
          </button>
        </div>

        <div class="quiz-footer">
          <span>正确 {{ score.correct }} / 错误 {{ score.wrong }}</span>
          <span>第 {{ answered + 1 }} 题</span>
        </div>

        <div class="end-row">
          <el-button type="danger" plain @click="endPractice">结束练习</el-button>
        </div>

        <el-dialog v-model="showEndDialog" title="错题确认" width="420px">
          <p>以下 <strong>{{ wrongList.length }}</strong> 个词答错了,确认明天添加到复习计划吗? </p>
          <div v-for="(item, index) in wrongList" :key="index" class="wrong-item">
            <div class="wrong-info">
              <span class="wrong-kanji" v-if="item.kanji">{{ item.kanji }}</span>
              <span class="wrong-kana">{{ item.kana }}</span>
              <span class="wrong-meaning">{{ item.meaning }}</span>
            </div>
            <div class="wrong-actions">
              <button class="sound-btn" @click="speakWord(item.kana)">🔊</button>
              <el-button size="small" circle type="danger" plain @click="wrongList.splice(index, 1)" />
            </div>
          </div>
          <template #footer>
            <el-button @click="handleCancelWrong">取消, 不算错</el-button>
            <el-button type="primary" @click="handleConfirmWrong">确认加入复习计划</el-button>
          </template>
        </el-dialog>
      </div>
    </Transition>
    </template>
  </div>
</template>

<script setup lang="ts">

import {onMounted, onUnmounted, ref} from "vue";
import {confirmMistakes, getQuestion, submitAnswer} from "../api";
import {ElMessage} from "element-plus";
import { initVoice, speakWord } from "../utils/speech";

const loading = ref(false);
const firstLoad = ref(true);
const question = ref<any>(null)
const selected = ref<number | null>(null)
const answered = ref(0)
const score = ref({ correct : 0, wrong: 0 })
const wrongList = ref<any[]>([])
const showEndDialog = ref(false)
const quizType = ref('jp_to_cn')
const modeChosen = ref(false)

//选类型
function switchType(type: string) {
  quizType.value = type
  modeChosen.value = true
  fetchQuestion()
}
//题干
async function fetchQuestion() {
  selected.value = null
  if (firstLoad.value) loading.value = true
  const res: any = await getQuestion(quizType.value)
  question.value = res.data
  loading.value = false
  firstLoad.value = false
//jp_cn发音
  if (quizType.value === 'jp_to_cn') speak()
}
//发音
function speak() {
  const t = question.value
  const text = t.correctKanji || t.correctKana || t.correctRomaji
  if (!text) return
  speakWord(text)
}
//选项
async function selectOption(vocabId: number) {
  if (selected.value !== null) return
  selected.value = vocabId
  const res: any = await submitAnswer({
    correctVocabId: question.value.correctVocabId,
    selectedVocabId: vocabId,
    quizType: quizType.value,
    allOptionIds: question.value.options.map((o: any) => o.vocabId),
  })
  if (res.data.correct) score.value.correct++
  else  { score.value.wrong++
  wrongList.value.push({
    vocabId: question.value.correctVocabId,
    kana: question.value.correctKana,
    kanji: question.value.correctKanji,
    meaning: question.value.correctMeaning,
  })}
}
//选项样式
function optionClass(vocabId: number) {
  if (!selected.value) return ''
  if (vocabId === question.value.correctVocabId) return 'correct'
  if (vocabId === selected.value) return 'wrong'
  return ''
}

function nextQuestion() {
  if (selected.value === null) return
  answered.value++
  fetchQuestion()
}

function endPractice() {
  if (wrongList.value.length > 0)showEndDialog.value = true
  else { ElMessage.success('牛逼全对')
  resetPractice()}
}

async function handleConfirmWrong() {
  await confirmMistakes(wrongList.value.map((item: any) => item.vocabId))
  ElMessage.success(`${wrongList.value.length} 个错题已加入明天复习计划`)
  showEndDialog.value = false
  resetPractice()
}

function handleCancelWrong() {
  showEndDialog.value = false
  wrongList.value = []
  ElMessage.info('已丢弃错题记录')
  resetPractice()
}

function resetPractice() {
  score.value = { correct: 0, wrong: 0 }
  answered.value = 0
  wrongList.value = []
  question.value = null
  selected.value = null
  modeChosen.value = false
  firstLoad.value = true
}

function handleKeydown(e: KeyboardEvent) {
  if (e.code === 'Space' && selected.value !== null) {
    e.preventDefault()
    nextQuestion()
  }
}

onMounted(() => {
  initVoice()
  window.addEventListener('keydown', handleKeydown)
})
onUnmounted(() => {
  window.removeEventListener('keydown', handleKeydown)
})


</script>

<style scoped>
.practice-page {
  text-align: left;
}

/* ---- 模式选择卡片 ---- */
.mode-grid {
  display: grid;
  grid-template-columns: repeat(2, minmax(0, 1fr));
  gap: 14px;
  margin-bottom: 20px;
}

.mode-card {
  background: var(--bg-card);
  border: 1px solid var(--border);
  border-radius: 10px;
  padding: 20px;
  cursor: pointer;
  transition: border-color 0.2s, background 0.2s, box-shadow 0.2s;
}

.mode-card:hover {
  border-color: #534ab7;
  background: var(--mode-active-bg);
  box-shadow: 0 2px 8px rgba(83, 74, 183, 0.15);
}
.quiz-option:hover {
  border-color: #534ab7;
  background: var(--mode-active-bg);
  box-shadow: 0 2px 8px rgba(83, 74, 183, 0.15);
}
.mode-icon {
  width: 40px;
  height: 40px;
  border-radius: 8px;
  display: flex;
  align-items: center;
  justify-content: center;
  margin-bottom: 12px;
  font-size: 16px;
  font-weight: 600;
}

.jp-icon {
  background: #EEEDFE;
  color: #534AB7;
}

.cn-icon {
  background: #FAEEDA;
  color: #854F0B;
}

:root .jp-icon { background: #EEEDFE; color: #534AB7; }
:root .cn-icon { background: #FAEEDA; color: #854F0B; }

.mode-title {
  font-size: 15px;
  font-weight: 500;
  color: var(--text);
  margin-bottom: 4px;
}

.mode-desc {
  font-size: 13px;
  color: var(--text-secondary);
}

/* ---- 已选模式指示器 ---- */
.mode-indicator {
  display: flex;
  align-items: center;
  gap: 10px;
  margin-bottom: 20px;
}

.mode-pill {
  display: inline-block;
  padding: 4px 14px;
  border-radius: 20px;
  font-size: 13px;
  font-weight: 500;
  background: #534ab7;
  color: #fff;
}

.mode-hint {
  font-size: 12px;
  color: var(--text-muted);
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

/* ---- 题目区 ---- */
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

.cn-text {
  font-size: 36px;
  font-weight: 500;
  color: var(--text);
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

/* ---- 选项 ---- */
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

/* 选择后非选中选项保持边框可见 */
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

/* ---- 底部 ---- */
.quiz-footer {
  display: flex;
  justify-content: space-between;
  color: var(--text-muted);
  font-size: 13px;
  margin-top: 18px;
}

@media (max-width: 900px) {
  .mode-grid,
  .quiz-options {
    grid-template-columns: 1fr;
  }
}

.opt-kanji {
  font-size: 18px;
  font-weight: 500;
}

.opt-kana {
  font-size: 14px;
  color: var(--text-secondary);
  margin-top: 2px;
}

.opt-romaji {
  font-size: 12px;
  color: var(--text-muted);
  margin-top: 2px;
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

.end-row {
  text-align: center;
  margin-top: 16px;
}

.wrong-item {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 6px 8px;
  border-bottom: 1px solid var(--border);
}

.wrong-word {
  font-size: 14px;
  color: var(--text);
}

.wrong-item button {
  cursor: pointer;
}

.wrong-info {
  display: flex;
  flex-direction: column;
  gap: 2px;
}

.wrong-kanji {
  font-size: 16px;
  font-weight: 500;
  color: var(--text);
}

.wrong-kana {
  font-size: 13px;
  color: var(--text-secondary);
}

.wrong-meaning {
  font-size: 13px;
  color: var(--text-muted);
}

.wrong-actions {
  display: flex;
  align-items: center;
  gap: 6px;
}

.sound-btn-sm {
  border: 1px solid var(--border);
  border-radius: 4px;
  padding: 2px 8px;
  background: var(--bg-card);
  cursor: pointer;
  font-size: 14px;
}

.sound-btn-sm:hover {
  background: var(--hover-bg);
}

</style>
