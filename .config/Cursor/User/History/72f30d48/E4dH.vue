<template>
  <div class="min-h-screen flex items-center justify-center bg-base-200">
    <div class="card w-96 bg-base-100 shadow-xl">
      <div class="card-body">
        <h2 class="card-title text-2xl font-bold mb-4 font-heading">Connexion</h2>
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
      <div>
        <label for="password" class="block text-sm font-medium">Mot de passe</label>
        <input v-model="password" id="password" type="password" required class="mt-1 block w-full input input-bordered" />
      </div>
      <div v-if="error" class="text-red-600 text-sm">{{ error }}</div>
      <button type="submit" class="btn btn-primary w-full">Se connecter</button>
    </form>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue'
import { useRouter } from 'vue-router'
import { supabase } from '@/lib/supabase'
import { useRecaptchaV3 } from '@/composables/useRecaptchaV3'

const email = ref('')
const password = ref('')
const error = ref('')
const router = useRouter()
const { executeRecaptcha } = useRecaptchaV3()

const handleLogin = async () => {
  error.value = ''

  try {
    const token = await executeRecaptcha('login')

    const response = await fetch('https://ycsspkxrthzpqugqxasm.functions.supabase.co/verify-recaptcha', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'apikey': import.meta.env.VITE_SUPABASE_ANON_KEY
      },
      body: JSON.stringify({ token, action: 'login' })
    })

    const result = await response.json()

    if (!result.success) {
      error.value = 'Échec de vérification reCAPTCHA.'
      return
    }

    const { error: loginError } = await supabase.auth.signInWithPassword({ email: email.value, password: password.value })

    if (loginError) {
      error.value = loginError.message
      return
    }

    router.push('/app')
  } catch (err) {
    console.error(err)
    error.value = 'Une erreur est survenue.'
  }
}
</script>

