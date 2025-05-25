<template>
  <div class="min-h-screen flex items-center justify-center bg-base-200">
    <div class="card w-96 bg-base-100 shadow-xl">
      <div class="card-body">
        <h2 class="card-title text-2xl font-bold mb-4">Inscription</h2>
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
          <div class="form-control">
            <label class="label">
              <span class="label-text">Confirmer le mot de passe</span>
            </label>
            <input
              type="password"
              v-model="confirmPassword"
              placeholder="••••••••"
              class="input input-bordered"
              required
            />
          </div>
          <div class="form-control mt-6">
            <button type="submit" class="btn btn-primary" :disabled="loading">
              <span v-if="loading" class="loading loading-spinner"></span>
              S'inscrire
            </button>
          </div>
        </form>
        <div class="text-center mt-4">
          <p class="text-sm">
            Déjà un compte ?
            <router-link to="/login" class="link link-primary">Se connecter</router-link>
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
const confirmPassword = ref('')
const loading = ref(false)
const router = useRouter()
const authStore = useAuthStore()

async function handleSubmit() {
  if (password.value !== confirmPassword.value) {
    // TODO: Afficher l'erreur à l'utilisateur
    console.error('Les mots de passe ne correspondent pas')
    return
  }

  loading.value = true
  const { error } = await authStore.signUp(email.value, password.value)
  loading.value = false
  
  if (!error) {
    // TODO: Afficher un message de succès et rediriger vers la page de connexion
    router.push('/login')
  } else {
    // TODO: Afficher l'erreur à l'utilisateur
    console.error('Erreur d\'inscription:', error)
  }
}
</script> 