<template>
  <div class="min-h-screen flex flex-col bg-cream text-gray-800">
    <!-- Hero Section -->
    <section class="flex-1 flex flex-col items-center justify-center px-4 py-16 text-center">
      <h1 class="text-4xl md:text-5xl font-extrabold mb-4 tracking-tight">
        Do one thing. Every day.
      </h1>
      <p class="text-lg md:text-xl mb-8 text-gray-600">
        A calm app to help you focus on just one meaningful intention.
      </p>
      <a
        href="/app"
        class="btn btn-primary btn-lg rounded-full px-8 shadow-md transition hover:scale-105"
      >
        Open the app &rarr;
      </a>
    </section>

    <!-- How it works -->
    <section class="bg-base-100/80 py-12 px-4">
      <div class="max-w-2xl mx-auto">
        <h2 class="text-2xl font-bold mb-8 text-center">How it works</h2>
        <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
          <div class="flex flex-col items-center">
            <div class="text-4xl mb-2">📝</div>
            <div class="font-semibold text-gray-700">Write your intention</div>
            <div class="text-sm text-gray-500 mt-1">Just one thing for today.</div>
          </div>
          <div class="flex flex-col items-center">
            <div class="text-4xl mb-2">✅</div>
            <div class="font-semibold text-gray-700">Mark as done</div>
            <div class="text-sm text-gray-500 mt-1">Celebrate your focus.</div>
          </div>
          <div class="flex flex-col items-center">
            <div class="text-4xl mb-2">📅</div>
            <div class="font-semibold text-gray-700">See your streak</div>
            <div class="text-sm text-gray-500 mt-1">Build a mindful habit.</div>
          </div>
        </div>
      </div>
    </section>
  </div>
</template>

<style scoped>
.bg-cream {
  @apply bg-[#fdf6ee];
}
</style> 