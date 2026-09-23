import {createRouter, createWebHistory} from "vue-router";
import Vocabulary from "../views/Vocabulary.vue";
import Home from "../views/Home.vue";
import AddVocab from "../views/AddVocab.vue";
import Practice from "../views/Practice.vue";
import Review from "../views/Review.vue";
import Dictation from "../views/Dictation.vue";


const router = createRouter({
    history: createWebHistory(),
    routes: [
        { path: '/', component: Home },
        { path: '/vocabulary', component: Vocabulary },
        { path: '/vocabulary/add', component: AddVocab },
        { path: '/practice', component: Practice },
        { path: '/review', component: Review },
        { path: '/dictation', component: Dictation },
    ]
})

export default router