import { createRouter, createWebHistory } from 'vue-router'
import Landing from './Landing.vue'
import App from './App.vue'

const routes = [
  { path: '/', component: Landing },
  { path: '/app', component: App },
]

const router = createRouter({
  history: createWebHistory(),
  routes,
})

export default router 