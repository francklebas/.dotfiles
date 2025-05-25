<template>
  <div class="min-h-screen flex items-center justify-center bg-base-200">
    <div class="card w-96 bg-base-100 shadow-xl">
      <div class="card-body">
        <h2 class="card-title text-2xl font-bold mb-4">Connexion</h2>
        <form @submit.prevent="handleSubmit" class="space-y-4">
          <div class="form-control">
            <label class="label">
              <span class="label-text">Email</span>
            </label>
            <input
              type="email"
              v-model="email"
              placeholder="votre@email.com"
              class="input input-bordered"
              required
            />
          </div>
          <div class="form-control">
            <label class="label">
              <span class="label-text">Mot de passe</span>
            </label>
            <input
              type="password"
              v-model="password"
              placeholder="••••••••"
              class="input input-bordered"
              required
            />
          </div>
          <div class="form-control mt-6">
            <button type="submit" class="btn btn-primary" :disabled="loading">
              <span v-if="loading" class="loading loading-spinner"></span>
              Se connecter
            </button>
          </div>
        </form>
        <div class="text-center mt-4">
          <p class="text-sm">
            Pas encore de compte ?
            <router-link to="/signup" class="link link-primary">S'inscrire</router-link>
          </p>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue'
import { useRouter } from 'vue-router'
import { useAuthStore } from '@/stores/auth'

const email = ref('')
const password = ref('')
const loading = ref(false)
const router = useRouter()
const authStore = useAuthStore()

async function handleSubmit() {
  loading.value = true
  const { error } = await authStore.signIn(email.value, password.value)
  loading.value = false
  
  if (!error) {
    router.push('/app')
  } else {
    // TODO: Afficher l'erreur à l'utilisateur
    console.error('Erreur de connexion:', error)
  }
}
</script> 