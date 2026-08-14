export interface ApiResponse<T> {
    code: number
    message: string
    data: T
}

export interface Vocabulary {
    id?: number
    kana: string
    kanji: string
    romaji: string
    meaning: string
    english?: string
    example?: string
    note?: string
    important: number
    createdAt?: string
    updatedAt?: string
}

export interface AnalyzeResult {
    kana: string
    kanji: string
    romaji: string
    meaning: string
    english: string
    duplicate: boolean
    message?: string
}

// 今日复习概览
export interface TodayReview {
    totalCount: number
    vocabList: Vocabulary[]
}

// 选项
export interface Option {
    vocabId: number
    kana: string
    kanji: string
    romaji: string
    meaning: string
}

// 题目
export interface QuizQuestion {
    correctVocabId: number
    quizType: string
    correctKana: string
    correctKanji: string
    correctRomaji: string
    correctMeaning: string
    options: Option[]
}

// 提交答案
export interface SubmitPayload {
    correctVocabId: number
    selectedVocabId: number
    quizType: string
    allOptionIds: number[]
}

// 作答结果
export interface QuizResult {
    correct: boolean
    correctVocabId: number
    selectedVocabId: number
    allOptions: Vocabulary[]
}

//分页查询
export interface PageResult<T> {
    total: number
    list: T[]
}
