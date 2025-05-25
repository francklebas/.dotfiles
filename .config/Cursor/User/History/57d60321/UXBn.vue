<!-- src/components/ThemeToggle.vue -->
<template>
    <label class="swap swap-rotate">
        <input type="checkbox" :checked="theme === 'dark'" @change="toggleTheme" />
        <!-- Icône soleil (light) -->
        <svg v-if="theme !== 'dark'" class="swap-on w-8 h-8" xmlns="http://www.w3.org/2000/svg" fill="none"
            viewBox="0 0 24 24" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                d="M12 3v1m0 16v1m8.66-11h-1M4.34 12h-1m15.36 4.95l-.707.707M6.343 6.343l-.707.707m12.727 0l-.707-.707M6.343 17.657l-.707-.707M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
        </svg>
        <!-- Icône lune (dark) -->
        <svg v-else class="swap-off w-8 h-8" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24"
            stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                d="M21 12.79A9 9 0 1111.21 3 7 7 0 0021 12.79z" />
        </svg>
    </label>
</template>

<script setup>
import { useTheme } from '../composables/useTheme'
import { defineOptions } from 'vue'

defineOptions({
    name: 'ThemeToggle'
})

const { theme, toggleTheme } = useTheme()
</script>