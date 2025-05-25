<template>
  <div class="flex flex-col items-center justify-center min-h-screen bg-base-200">
    <div v-if="!todayIntention || !todayIntention.done" class="w-full max-w-md">
      <input
        v-model="intentionText"
        type="text"
        placeholder="Today, I want to..."
        class="input input-bordered w-full mb-4"
      />
      <button
        @click="saveIntention"
        :disabled="!intentionText"
        class="btn btn-primary w-full"
      >
        Mark as done
      </button>
    </div>
    <div v-else class="text-center">
      <p class="text-lg">You've done it. Come back tomorrow!</p>
    </div>
    <div class="mt-8 w-full max-w-md">
      <h2 class="text-xl mb-4">Last 7 Days</h2>
      <ul>
        <li v-for="entry in last7Days" :key="entry.date" class="flex justify-between items-center mb-2">
          <span>{{ entry.date }}</span>
          <span>{{ entry.text }}</span>
          <span>{{ entry.done ? '✅' : '⚪' }}</span>
        </li>
      </ul>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      intentionText: '',
      todayIntention: null,
      last7Days: []
    };
  },
  created() {
    this.loadIntentions();
  },
  methods: {
    loadIntentions() {
      const today = new Date().toLocaleDateString('en-US', { weekday: 'short' });
      const storedIntentions = JSON.parse(localStorage.getItem('intentions') || '[]');
      this.last7Days = storedIntentions.slice(-7);
      this.todayIntention = this.last7Days.find(entry => entry.date === today);
    },
    saveIntention() {
      const today = new Date().toLocaleDateString('en-US', { weekday: 'short' });
      const newIntention = { date: today, text: this.intentionText, done: false };
      this.last7Days.push(newIntention);
      localStorage.setItem('intentions', JSON.stringify(this.last7Days));
      this.todayIntention = newIntention;
      this.intentionText = '';
    }
  }
};
</script>

<style>
@import 'tailwindcss/tailwind.css';
</style> 