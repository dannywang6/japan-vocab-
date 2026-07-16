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
      <el-table :data="list" v-loading="loading" border stripe @row-click="handleRowClick" class="vocab-table">
        <el-table-column prop="kana" label="假名" width="120" />
        <el-table-column prop="kanji" label="日汉字" width="120" />
        <el-table-column prop="romaji" label="罗马字" width="120" />
        <el-table-column prop="meaning" label="中文" width="120" />
        <el-table-column label="英文" width="120">
          <template #default="{ row }">
            <span v-if="row.english">{{ row.english }}</span>
            <span v-else style="color:#ccc;">—</span>
          </template>
        </el-table-column>
        <el-table-column prop="example" label="例句" min-width="160" />
        <el-table-column label="重点" width="70" align="center">
          <template #default="{ row }">
            <el-tag v-if="row.important === 1" type="danger" size="small">重点</el-tag>
          </template>
        </el-table-column>
        <el-table-column label="操作" width="150">
          <template #default="{ row }">
            <el-button size="small" @click.stop="openEdit(row)">编辑</el-button>
            <el-button size="small" type="danger" @click.stop="handleDelete(row.id)">删除</el-button>
          </template>
        </el-table-column>
      </el-table>
    </div>

    <!-- 编辑弹窗 -->
    <el-dialog v-model="dialogVisible" title="编辑词汇" width="90%" :style="{ maxWidth: '500px' }">
      <el-form :model="editForm" label-width="80px">
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
        <el-form-item label="例句">
          <el-input v-model="editForm.example" type="textarea" />
        </el-form-item>
        <el-form-item label="备注">
          <el-input v-model="editForm.note" type="textarea" />
        </el-form-item>
        <el-form-item label="重点词汇">
          <el-switch v-model="editForm.important" :active-value="1" :inactive-value="0" />
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="dialogVisible = false">取消</el-button>
        <el-button type="primary" @click="handleUpdate">保存</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import {getVocabularyList, deleteVocabulary, updateVocabulary, searchVocabulary} from '../api/index'
import { initVoice, speakWord } from '../utils/speech'

const list = ref([])
const loading = ref(false)
const dialogVisible = ref(false)
const editForm = ref<any>({})
const searchKeyword = ref('')


const handleSearch = async () => {
  if (!searchKeyword.value.trim()) {
    fetchList()
    return
  }
  loading.value = true
  try {
    const res: any = await searchVocabulary(searchKeyword.value)
    list.value = res.data
  } finally {
    loading.value = false
  }
}

const fetchList = async () => {
  loading.value = true
  try {
    const res: any = await getVocabularyList()
    list.value = res.data
  } finally {
    loading.value = false
  }
}

const openEdit = (row: any) => {
  editForm.value = { ...row }
  dialogVisible.value = true
}

const handleUpdate = async () => {
  await updateVocabulary(editForm.value.id, editForm.value)
  ElMessage.success('修改成功')
  dialogVisible.value = false
  fetchList()
}

const handleDelete = async (id: number) => {
  await ElMessageBox.confirm('确定删除这个词汇吗？', '提示', { type: 'warning' })
  await deleteVocabulary(id)
  ElMessage.success('删除成功')
  fetchList()
}

const handleRowClick = (row: any) => {
  speakWord(row.kanji || row.kana)
}

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

.vocab-table :deep(.el-table__row) {
  cursor: pointer;
  transition: background-color 0.2s;
}

.vocab-table :deep(.el-table__row:hover) {
  background-color: #f5f7fa !important;
}
</style>