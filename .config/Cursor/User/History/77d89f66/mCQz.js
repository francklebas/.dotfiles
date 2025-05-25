import { createRouter, createWebHistory } from 'vue-router'
import LandingPage from '../pages/LandingPage.vue'
import AppView from '../App.vue' // c’est ton app principale, ne surtout pas y toucher

const routes = [
  { path: '/', component: LandingPage },
  { path: '/app', component: AppView },
]

const router = createRouter({
  history: createWebHistory(),
  routes,
})

export default router