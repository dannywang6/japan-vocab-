<template>
  <div style="max-width: 600px;">
    <el-form :model="form" :rules="rules" ref="formRef" label-width="80px">

      <!-- 中文 -->
      <el-form-item label="中文" prop="meaning">
        <el-input
            v-model="form.meaning"
            @input="onFieldChange('meaning')"
            @keydown.enter.prevent="handleAnalyze"
        />
      </el-form-item>

      <!-- 假名 -->
      <el-form-item label="假名" prop="kana">
        <div style="display: flex; align-items: center; gap: 8px; width: 100%;">
          <el-input
              v-model="form.kana"
              @input="onFieldChange('kana')"
              @keydown.enter.prevent="handleAnalyze"
              style="flex: 1;"
          />

          <button
              type="button"
              class="sound-btn-sm"
              @click="speakWord(form.kana)"
          >
            🔊
          </button>
        </div>
      </el-form-item>

      <!-- 日汉字 -->
      <el-form-item label="日汉字">
        <el-input
            v-model="form.kanji"
            @input="onFieldChange('kanji')"
            @keydown.enter.prevent="handleAnalyze"
        />
      </el-form-item>

      <!-- 罗马字 -->
      <el-form-item label="罗马字" prop="romaji">
        <el-input
            v-model="form.romaji"
            @input="onFieldChange('romaji')"
            @keydown.enter.prevent="handleAnalyze"
        />
      </el-form-item>

      <!-- 英文 -->
      <el-form-item label="英文">
        <el-input
            v-model="form.english"
            @input="onFieldChange('english')"
            @keydown.enter.prevent="handleAnalyze"
        />
      </el-form-item>

      <!-- 词性 -->
      <el-form-item label="词性">
        <el-input
            v-model="form.partOfSpeech"
            placeholder="例如：名词、动词、い形容词"
        />
      </el-form-item>

      <!-- 例句 -->
      <el-form-item label="例句">
        <div style="width: 100%;">
          <div
              style="
                display: flex;
                align-items: flex-start;
                gap: 8px;
                width: 100%;
              "
          >
            <el-input
                v-model="form.example"
                type="textarea"
                :rows="3"
                placeholder="AI 自动生成日语例句"
                style="flex: 1;"
            />

            <!-- 例句发音 -->
            <button
                v-if="form.example"
                type="button"
                class="sound-btn-sm example-sound-btn"
                @click="speakWord(form.example)"
            >
              🔊
            </button>
          </div>
        </div>
      </el-form-item>

      <!-- 例句中文 -->
      <el-form-item label="例句中文">
        <el-input
            v-model="form.exampleMeaning"
            type="textarea"
            :rows="3"
            placeholder="AI 自动生成例句中文翻译"
        />
      </el-form-item>

      <!-- 备注 -->
      <el-form-item label="备注">
        <el-input
            v-model="form.note"
            type="textarea"
        />
      </el-form-item>

      <!-- 重点词汇 -->
      <el-form-item label="重点词汇">
        <el-switch
            v-model="form.important"
            :active-value="1"
            :inactive-value="0"
        />
      </el-form-item>

      <!-- 按钮 -->
      <el-form-item>
        <el-button
            type="warning"
            :loading="analyzing"
            @click="handleAnalyze"
        >
          自动填充
        </el-button>

        <el-button
            type="primary"
            :loading="submitting"
            @click="handleSubmit"
        >
          保存词汇
        </el-button>

        <el-button @click="$router.push('/vocabulary')">
          取消
        </el-button>
      </el-form-item>

    </el-form>
  </div>
</template>


<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { ElMessage } from 'element-plus'
import { addVocabulary, analyzeWord } from '../api/index'
import { useRouter } from 'vue-router'
import {
  initVoice,
  speakWord
} from '../utils/speech.ts'

const router = useRouter()

const formRef = ref()
const lastEditedField = ref('')

const analyzing = ref(false)
const submitting = ref(false)
const isDuplicate = ref(false)


// 初始化语音
onMounted(() => {
  initVoice()
})


// 表单
const form = ref({
  kana: '',
  kanji: '',
  romaji: '',
  meaning: '',
  english: '',

  // 新增
  example: '',
  exampleMeaning: '',
  partOfSpeech: '',

  note: '',
  important: 0,
})


// 表单验证
const rules = {
  kana: [
    {
      required: true,
      message: '假名不能为空',
      trigger: 'blur'
    }
  ],

  romaji: [
    {
      required: true,
      message: '罗马字不能为空',
      trigger: 'blur'
    }
  ],

  meaning: [
    {
      required: true,
      message: '中文翻译不能为空',
      trigger: 'blur'
    }
  ],
}


// 自动填充
const handleAnalyze = async () => {

  const word =
      form.value.kana ||
      form.value.kanji ||
      form.value.meaning ||
      form.value.english

  if (!word) {
    ElMessage.warning('请先输入任意要补全的字段')
    return
  }

  analyzing.value = true

  try {

    const res: any = await analyzeWord(word)

    const data = res.data

    if (res.code === 200 && res.data) {

      // 原来的字段
      if (lastEditedField.value !== 'kana') {
        form.value.kana = data.kana || form.value.kana
      }

      if (lastEditedField.value !== 'kanji') {
        form.value.kanji = data.kanji || form.value.kanji
      }

      if (lastEditedField.value !== 'romaji') {
        form.value.romaji = data.romaji || form.value.romaji
      }

      if (lastEditedField.value !== 'meaning') {
        form.value.meaning = data.meaning || form.value.meaning
      }

      if (lastEditedField.value !== 'english') {
        form.value.english = data.english || form.value.english
      }


      // =========================
      // 新增字段
      // =========================

      // 例句
      form.value.example = data.example || form.value.example

      // 例句中文
      form.value.exampleMeaning =
          data.exampleMeaning || form.value.exampleMeaning

      // 词性
      form.value.partOfSpeech =
          data.partOfSpeech || form.value.partOfSpeech


      // 查重
      isDuplicate.value = !!data.duplicate


      if (data.duplicate) {

        ElMessage.warning(
            data.message || '该词汇已存在'
        )

      } else if (data.message) {

        ElMessage.warning(data.message)

      } else {

        ElMessage.success('填充完成')

      }

    } else {

      ElMessage.error(
          res.message || '填充失败'
      )

    }

  } catch (e) {

    ElMessage.error('填充失败')

  } finally {

    analyzing.value = false

  }
}


// 提交
const handleSubmit = async () => {

  if (isDuplicate.value) {

    ElMessage.warning(
        '该词汇已存在,请勿重复添加'
    )

    return
  }

  await formRef.value.validate()

  submitting.value = true

  try {

    await addVocabulary(form.value)

    ElMessage.success('添加成功')

    router.push('/vocabulary')

  } finally {

    submitting.value = false

  }
}


// 用户手动修改字段
const onFieldChange = (field: string) => {

  lastEditedField.value = field

  if (field !== 'kana') {
    form.value.kana = ''
  }

  if (field !== 'kanji') {
    form.value.kanji = ''
  }

  if (field !== 'romaji') {
    form.value.romaji = ''
  }

  if (field !== 'meaning') {
    form.value.meaning = ''
  }

  if (field !== 'english') {
    form.value.english = ''
  }

}
</script>


<style scoped>

.sound-btn-sm {
  border: 1px solid var(--border);
  border-radius: 4px;
  padding: 4px 10px;
  background: var(--bg-card);
  cursor: pointer;
  font-size: 16px;
  flex-shrink: 0;
}

.sound-btn-sm:hover {
  background: var(--hover-bg);
}

/* 例句发音按钮 */
.example-sound-btn {
  margin-top: 2px;
}

</style>