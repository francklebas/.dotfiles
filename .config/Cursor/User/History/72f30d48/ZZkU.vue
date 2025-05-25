<template>
  <div class="max-w-md mx-auto mt-10 p-6 bg-white rounded-xl shadow-md">
    <h1 class="text-2xl font-semibold mb-4">Connexion</h1>
    <form @submit.prevent="handleLogin" class="space-y-4">
      <div>
        <label for="email" class="block text-sm font-medium">Email</label>
        <input v-model="email" id="email" type="email" required class="mt-1 block w-full input input-bordered" />
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
