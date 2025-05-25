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
      <div v-if="error" class="text-red-600 text-sm">{{ error }}</div>
      <button type="submit" class="btn btn-primary w-full">S’inscrire</button>
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

const handleSignup = async () => {
  error.value = ''

  try {
    const token = await executeRecaptcha('signup')

    const response = await fetch('https://ycsspkxrthzpqugqxasm.functions.supabase.co/verify-recaptcha', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'apikey': import.meta.env.VITE_SUPABASE_ANON_KEY
      },
      body: JSON.stringify({ token, action: 'signup' })
    })

    const result = await response.json()

    if (!result.success) {
      error.value = 'Échec de vérification reCAPTCHA.'
      return
    }

    const { error: signupError } = await supabase.auth.signUp({ email: email.value, password: password.value })

    if (signupError) {
      error.value = signupError.message
      return
    }

    router.push('/app')
  } catch (err) {
    console.error(err)
    error.value = 'Une erreur est survenue.'
  }
}
</script>


