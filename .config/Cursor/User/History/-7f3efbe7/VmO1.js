import { createApp } from 'vue'
import App from './App.vue'
import router from './router'
import './assets/index.css' // avec Tailwind + DaisyUI

createApp(App).use(router).mount('#app')