import { createRouter, createWebHistory } from 'vue-router'
import LandingPage from '../pages/LandingPage.vue'
import AppView from '../pages/AppView.vue'

const routes = [
  { path: '/', component: LandingPage },
  { path: '/app', component: AppView }
]

export default createRouter({
  history: createWebHistory(),
  routes
})
