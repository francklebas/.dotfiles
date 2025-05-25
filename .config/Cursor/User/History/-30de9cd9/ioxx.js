// src/composables/useTheme.js
import { ref, onMounted, watch } from 'vue'

export function useTheme() {
  const theme = ref('light')

  const setTheme = (t) => {
    theme.value = t
    document.documentElement.setAttribute('data-theme', t)
    localStorage.setItem('theme', t)
  }

  const toggleTheme = () => {
    setTheme(theme.value === 'dark' ? 'light' : 'dark')
  }

  onMounted(() => {
    const saved = localStorage.getItem('theme')
    setTheme(saved === 'dark' ? 'dark' : 'light')
  })

  // veille à appliquer le theme dès qu'il change
  watch(theme, (t) => {
    document.documentElement.setAttribute('data-theme', t)
  })

  return { theme, toggleTheme }
}
