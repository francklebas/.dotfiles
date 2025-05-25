<template>
    <main class="min-h-screen flex items-center justify-center bg-base-100 text-base-content px-4">
      <div class="max-w-xl w-full text-center space-y-12">
        <section class="space-y-4">
          <h1 class="text-3xl font-bold">Do one thing. Every day.</h1>
          <p class="text-lg">
            A calm app to help you focus on just one meaningful intention.  
            No pressure. No to-do lists. Just presence.
          </p>
          <a href="/app" class="btn btn-primary">Open the app →</a>
        </section>
        <section class="text-left space-y-4">
          <h2 class="text-xl font-semibold">How it works</h2>
          <ul class="space-y-2">
            <li class="flex items-center gap-3"><span class="text-xl">📝</span><span>Write your intention</span></li>
            <li class="flex items-center gap-3"><span class="text-xl">✅</span><span>Mark it as done</span></li>
            <li class="flex items-center gap-3"><span class="text-xl">🌙</span><span>Come back tomorrow</span></li>
          </ul>
        </section>
        <section class="italic text-sm opacity-70">
          “Success is built on doing the right thing, not doing everything.”
        </section>
        <footer class="border-t pt-4 text-sm opacity-60">
          © 2025 OneThing.Today — All rights reserved.
        </footer>
      </div>
    </main>
  </template>
  
  <script setup>
  import { useTheme } from '../composables/useTheme'

const { theme, toggleTheme } = useTheme()
  export default {
    name: 'LandingPage'
  }
  </script>
  