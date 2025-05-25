<script setup>
import { ref, computed, onMounted } from 'vue'

const newIntention = ref('')
const intentions = ref({})

const today = new Date().toISOString().slice(0, 10)

const todayIntention = computed(() => intentions.value[today])

const lastSevenDays = computed(() => {
  const result = {}
  for (let i = 0; i < 7; i++) {
    const date = new Date()
    date.setDate(date.getDate() - i)
    const dateStr = date.toISOString().slice(0, 10)
    result[dateStr] = intentions.value[dateStr] || { text: '', done: false }
  }
  return result
})

const getDayName = (dateStr) => {
  const days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat']
  return days[new Date(dateStr).getDay()]
}

const saveIntention = () => {
  if (!newIntention.value) return
  intentions.value[today] = {
    text: newIntention.value,
    done: false
  }
  localStorage.setItem('intentions', JSON.stringify(intentions.value))
  newIntention.value = ''
}

const markAsDone = () => {
  if (todayIntention.value) {
    todayIntention.value.done = true
    localStorage.setItem('intentions', JSON.stringify(intentions.value))
  }
}

onMounted(() => {
  const savedIntentions = localStorage.getItem('intentions')
  if (savedIntentions) {
    intentions.value = JSON.parse(savedIntentions)
  }
})
</script>

<template>
  <div class="min-h-screen bg-base-200 flex flex-col items-center justify-center p-4">
    <div class="card w-full max-w-md bg-base-100 shadow-xl">
      <div class="card-body">
        <h1 class="card-title text-2xl font-bold text-center mb-6">
          What is the one thing you want to do today?
        </h1>

        <div v-if="!todayIntention" class="space-y-4">
          <input
            v-model="newIntention"
            type="text"
            placeholder="Today, I want to..."
            class="input input-bordered w-full"
          />
          <button
            @click="saveIntention"
            :disabled="!newIntention"
            class="btn btn-primary w-full"
          >
            Create
          </button>
        </div>

        <div v-else class="space-y-4">
          <div class="text-center">
            <p class="text-lg">{{ todayIntention.text }}</p>
            <button
              v-if="!todayIntention.done"
              @click="markAsDone"
              class="btn btn-primary mt-4"
            >
              Mark as done
            </button>
            <p v-else class="text-success mt-4">You've done it. Come back tomorrow!</p>
          </div>
        </div>

        <div class="divider"></div>

        <div class="space-y-4">
          <h2 class="text-lg font-semibold">Last 7 days</h2>
          <div v-for="(intention, date) in lastSevenDays" :key="date" class="flex items-center gap-2">
            <div class="w-16 text-sm">{{ getDayName(date) }}</div>
            <div class="flex-1">{{ intention.text }}</div>
            <div
              class="w-4 h-4 rounded-full"
              :class="intention.done ? 'bg-success' : 'bg-base-300'"
            ></div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>
.logo {
  height: 6em;
  padding: 1.5em;
  will-change: filter;
  transition: filter 300ms;
}
.logo:hover {
  filter: drop-shadow(0 0 2em #646cffaa);
}
.logo.vue:hover {
  filter: drop-shadow(0 0 2em #42b883aa);
}
</style>
