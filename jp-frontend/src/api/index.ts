import axios from "axios";
import type {
    ApiResponse,
    Vocabulary,
    AnalyzeResult,
    QuizQuestion,
    QuizResult,
    SubmitPayload,
    TodayReview,
    PageResult
} from "../types";
import {ElMessage} from "element-plus";

const request = axios.create({
    baseURL: import.meta.env.VITE_API_BASE,
    timeout: 15000,
})
request.interceptors.response.use(
    (res) => {
        const body = res.data
        if (body && body.code !== 200) {
            ElMessage.error(body.message || '请求失败')
            return Promise.reject(new Error(body.message))
        }
        return body
    },
    (err) => {
        ElMessage.error('网络错误，请稍后重试')
        return Promise.reject(err)
    }
)

export const getVocabularyList = (): Promise<ApiResponse<Vocabulary[]>> =>
    request.get('/api/vocabularies')

export const getVocabularyById = (id: number): Promise<ApiResponse<Vocabulary>> =>
    request.get(`/api/vocabularies/${id}`)

export const addVocabulary = (data: Vocabulary): Promise<ApiResponse<null>> =>
    request.post(`/api/vocabularies`, data)

export const updateVocabulary = (id: number, data: Vocabulary): Promise<ApiResponse<null>> =>
    request.put(`/api/vocabularies/${id}`, data)

export const deleteVocabulary = (id: number): Promise<ApiResponse<null>> =>
    request.delete(`/api/vocabularies/${id}`)

// play练习
export const getQuestion = (type: string): Promise<ApiResponse<QuizQuestion>> =>
    request.get('/api/quiz/question', { params: { type } })

export const submitAnswer = (data: SubmitPayload): Promise<ApiResponse<QuizResult>> =>
    request.post(`/api/quiz/submit`, data)

export const confirmMistakes = (vocabIds: number[]): Promise<ApiResponse<null>> =>
    request.post(`/api/quiz/confirm-mistakes`, vocabIds)

// 复习
export const getTodayReview = (): Promise<ApiResponse<TodayReview>> =>
    request.get('/api/review/today')

export const completeReview = (vocabId: number, isCorrect: boolean): Promise<ApiResponse<null>> =>
    request.post(`/api/review/complete`, null, { params: { vocabId, isCorrect } })

export const getReviewQuestion = (): Promise<ApiResponse<QuizQuestion>> =>
    request.get('/api/review/question')

// 自动填充
export const analyzeWord = (word: string): Promise<ApiResponse<AnalyzeResult>> =>
    request.post(`/api/vocabularies/analyze`, { word })

// 全局搜索
export const searchVocabulary = (keyword: string): Promise<ApiResponse<Vocabulary[]>> =>
    request.get('/api/vocabularies/search', { params: { keyword } })

//分页查询
export const getVocabularyPage = (params: { keyword?: string; page?: number; size?: number }): Promise<ApiResponse<PageResult<Vocabulary>>> =>
    request.get('/api/vocabularies/page', { params })