```vue
<template>
  <div>
    <div class="toolbar">
      <el-button type="primary" @click="$router.push('/vocabulary/add')">
        <el-icon><Plus /></el-icon>添加词汇
      </el-button>

      <el-input
          v-model="searchKeyword"
          placeholder="搜索：中文/日文/假名/英文"
          clearable
          style="width: 250px; max-width: 100%; margin-left: 12px;"
          @input="handleSearch"
      />
    </div>

    <div style="overflow-x: auto">
      <el-table
          :data="list"
          v-loading="loading"
          border
          stripe
          @row-click="handleRowClick"
          class="vocab-table"
      >
        <el-table-column prop="kana" label="假名" width="120" />

        <el-table-column prop="kanji" label="日汉字" width="120" />

        <el-table-column prop="romaji" label="罗马字" width="120" />

        <el-table-column prop="meaning" label="中文" width="120" />

        <el-table-column label="英文" width="120">
          <template #default="{ row }">
            <span v-if="row.english">
              {{ row.english }}
            </span>
            <span v-else style="color: #ccc;">
              —
            </span>
          </template>
        </el-table-column>

        <!-- 词性 -->
        <el-table-column label="词性" width="100">
          <template #default="{ row }">
            <span v-if="row.partOfSpeech">
              {{ row.partOfSpeech }}
            </span>
            <span v-else style="color: #ccc;">
              —
            </span>
          </template>
        </el-table-column>

        <!-- 例句 -->
        <el-table-column label="例句" min-width="300">
          <template #default="{ row }">
            <div class="example-cell">
              <div class="example-japanese">
                <span v-if="row.example">
                  {{ row.example }}
                </span>
                <span v-else style="color: #ccc;">
                  —
                </span>

                <!-- 例句发音 -->
                <el-button
                    v-if="row.example"
                    class="speak-button"
                    size="small"
                    circle
                    @click.stop="speakWord(row.example)"
                >
                  🔊
                </el-button>
              </div>

              <!-- 例句中文 -->
              <div
                  v-if="row.exampleMeaning"
                  class="example-meaning"
              >
                {{ row.exampleMeaning }}
              </div>
            </div>
          </template>
        </el-table-column>

        <!-- 重点 -->
        <el-table-column label="重点" width="70" align="center">
          <template #default="{ row }">
            <el-tag
                v-if="row.important === 1"
                type="danger"
                size="small"
            >
              重点
            </el-tag>
          </template>
        </el-table-column>

        <!-- 操作 -->
        <el-table-column label="操作" width="150">
          <template #default="{ row }">
            <el-button
                size="small"
                @click.stop="openEdit(row)"
            >
              编辑
            </el-button>

            <el-button
                size="small"
                type="danger"
                @click.stop="handleDelete(row.id)"
            >
              删除
            </el-button>
          </template>
        </el-table-column>
      </el-table>
    </div>

    <!-- 分页 -->
    <div class="pagination-wrap">
      <el-pagination
          v-model:current-page="page"
          v-model:page-size="size"
          :total="total"
          :page-sizes="[20, 50, 100]"
          layout="total, sizes, prev, pager, next"
          @current-change="fetchList"
          @size-change="handleSizeChange"
      />
    </div>

    <!-- 编辑弹窗 -->
    <el-dialog
        v-model="dialogVisible"
        title="编辑词汇"
        width="90%"
        :style="{ maxWidth: '500px' }"
    >
      <el-form
          :model="editForm"
          label-width="80px"
      >
        <el-form-item label="假名">
          <el-input v-model="editForm.kana" />
        </el-form-item>

        <el-form-item label="汉字">
          <el-input v-model="editForm.kanji" />
        </el-form-item>

        <el-form-item label="罗马字">
          <el-input v-model="editForm.romaji" />
        </el-form-item>

        <el-form-item label="中文">
          <el-input v-model="editForm.meaning" />
        </el-form-item>

        <el-form-item label="英文">
          <el-input v-model="editForm.english" />
        </el-form-item>

        <!-- 词性 -->
        <el-form-item label="词性">
          <el-input v-model="editForm.partOfSpeech" />
        </el-form-item>

        <!-- 例句 -->
        <el-form-item label="例句">
          <el-input
              v-model="editForm.example"
              type="textarea"
              :rows="3"
          />
        </el-form-item>

        <!-- 例句中文 -->
        <el-form-item label="例句中文">
          <el-input
              v-model="editForm.exampleMeaning"
              type="textarea"
              :rows="3"
          />
        </el-form-item>

        <el-form-item label="备注">
          <el-input
              v-model="editForm.note"
              type="textarea"
          />
        </el-form-item>

        <el-form-item label="重点词汇">
          <el-switch
              v-model="editForm.important"
              :active-value="1"
              :inactive-value="0"
          />
        </el-form-item>
      </el-form>

      <template #footer>
        <el-button @click="dialogVisible = false">
          取消
        </el-button>

        <el-button
            type="primary"
            @click="handleUpdate"
        >
          保存
        </el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import type { Vocabulary } from '../types'
import { ElMessage, ElMessageBox } from 'element-plus'
import {
  deleteVocabulary,
  updateVocabulary,
  getVocabularyPage
} from '../api/index'
import {
  initVoice,
  speakWord
} from '../utils/speech'
import { useDebounceFn } from '@vueuse/core'

const list = ref<Vocabulary[]>([])
const loading = ref(false)
const dialogVisible = ref(false)
const editForm = ref<any>({})
const searchKeyword = ref('')
const page = ref(1)
const size = ref(20)
const total = ref(0)

/**
 * 搜索
 */
const handleSearch = useDebounceFn(async () => {
  page.value = 1
  await fetchList()
}, 300)

/**
 * 获取词汇列表
 */
const fetchList = async () => {
  loading.value = true

  try {
    const res: any = await getVocabularyPage({
      keyword: searchKeyword.value.trim(),
      page: page.value,
      size: size.value,
    })

    list.value = res.data.list
    total.value = res.data.total
  } catch (e) {
  } finally {
    loading.value = false
  }
}

/**
 * 修改每页数量
 */
const handleSizeChange = () => {
  page.value = 1
  fetchList()
}

/**
 * 打开编辑弹窗
 */
const openEdit = (row: any) => {
  editForm.value = { ...row }
  dialogVisible.value = true
}

/**
 * 保存修改
 */
const handleUpdate = async () => {
  await updateVocabulary(
      editForm.value.id,
      editForm.value
  )

  ElMessage.success('修改成功')

  dialogVisible.value = false

  fetchList()
}

/**
 * 删除
 */
const handleDelete = async (id: number) => {
  await ElMessageBox.confirm(
      '确定删除这个词汇吗？',
      '提示',
      {
        type: 'warning'
      }
  )

  await deleteVocabulary(id)

  ElMessage.success('删除成功')

  if (list.value.length === 1 && page.value > 1) {
    page.value -= 1
  }

  fetchList()
}

/**
 * 点击整行：
 * 播放单词
 */
const handleRowClick = (row: any) => {
  speakWord(row.kanji || row.kana)
}

/**
 * 页面加载
 */
onMounted(() => {
  initVoice()
  fetchList()
})
</script>

<style scoped>
.toolbar {
  margin-bottom: 16px;
  display: flex;
  align-items: center;
}

.pagination-wrap {
  margin-top: 16px;
  display: flex;
  justify-content: flex-end;
}

.vocab-table :deep(.el-table__row) {
  cursor: pointer;
  transition: background-color 0.2s;
}

.vocab-table :deep(.el-table__row:hover) {
  background-color: #f5f7fa !important;
}

/* 例句区域 */
.example-cell {
  display: flex;
  flex-direction: column;
  gap: 4px;
}

.example-japanese {
  display: flex;
  align-items: center;
  gap: 6px;
  line-height: 1.5;
}

/* 例句中文 */
.example-meaning {
  color: #999;
  font-size: 13px;
  line-height: 1.5;
}

/* 发音按钮 */
.speak-button {
  flex-shrink: 0;
}
</style>
```
