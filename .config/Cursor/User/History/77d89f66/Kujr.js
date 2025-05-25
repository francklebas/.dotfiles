import { createRouter, createWebHistory } from 'vue-router'
import LandingPage from '../components/LandingPage.vue'
import AppView from '../App.vue' // ou ton écran `/app` réel

const routes = [
  { path: '/', component: LandingPage },
  { path: '/app', component: AppView },
]

const router = createRouter({
  history: createWebHistory(),
  routes,
})

export default router
