<template>
  <div class="min-h-screen flex items-center justify-center bg-base-200">
    <div class="card w-96 bg-base-100 shadow-xl">
      <div class="card-body">
        <h2 class="card-title text-2xl font-bold mb-4 font-heading">Inscription</h2>
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
            <button type="submit" class="btn btn-primary" :disabled="loading || !isRecaptchaReady">
              <span v-if="loading" class="loading loading-spinner"></span>
              S'inscrire
            </button>
          </div>
        </form>
        <div v-if="error" class="alert alert-error mt-4">
          <svg xmlns="http://www.w3.org/2000/svg" class="stroke-current shrink-0 h-6 w-6" fill="none" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 14l2-2m0 0l2-2m-2 2l-2-2m2 2l2 2m7-2a9 9 0 11-18 0 9 9 0 0118 0z" /></svg>
          <span>{{ error }}</span>
        </div>
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
import { useRecaptchaV3 } from '@/composables/useRecaptchaV3'

const email = ref('')
const password = ref('')
const confirmPassword = ref('')
const loading = ref(false)
const router = useRouter()
const authStore = useAuthStore()
const { executeRecaptcha, isReady: isRecaptchaReady } = useRecaptchaV3()
const error = ref<string | null>(null)

async function handleSubmit() {
  if (!isRecaptchaReady.value) {
    error.value = 'reCAPTCHA n\'est pas encore prêt'
    return
  }

  if (password.value !== confirmPassword.value) {
    error.value = 'Les mots de passe ne correspondent pas'
    return
  }

  try {
    loading.value = true
    error.value = null

    // Obtenir le token reCAPTCHA
    const token = await executeRecaptcha('signup')

    // Tenter l'inscription
    const { error: authError } = await authStore.signUp(email.value, password.value, token)
    
    if (!authError) {
      router.push('/login')
    }
  } catch (err) {
    error.value = err instanceof Error ? err.message : 'Une erreur est survenue'
  } finally {
    loading.value = false
  }
}
</script> 