import { defineStore } from 'pinia'
import { createClient, SupabaseClient } from '@supabase/supabase-js'
import { ref } from 'vue'

interface User {
  id: string
  email: string
}

export const useAuthStore = defineStore('auth', () => {
  const supabase: SupabaseClient = createClient(
    import.meta.env.VITE_SUPABASE_URL,
    import.meta.env.VITE_SUPABASE_ANON_KEY
  )

  const user = ref<User | null>(null)
  const loading = ref(true)
  const error = ref<string | null>(null)

  async function verifyRecaptcha(token: string, action: string) {
    try {
      const response = await fetch(`${import.meta.env.VITE_SUPABASE_URL}/functions/v1/verify-recaptcha`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ token, action }),
      })

      const data = await response.json()
      if (!data.success) {
        throw new Error(data.error || 'Vérification reCAPTCHA échouée')
      }
      return true
    } catch (error) {
      console.error('Erreur de vérification reCAPTCHA:', error)
      throw error
    }
  }

  async function init() {
    try {
      const { data: { session } } = await supabase.auth.getSession()
      user.value = session?.user ?? null
    } catch (error) {
      console.error('Error initializing auth:', error)
    } finally {
      loading.value = false
    }
  }

  async function signIn(email: string, password: string, recaptchaToken: string) {
    try {
      // Vérifier le token reCAPTCHA
      await verifyRecaptcha(recaptchaToken, 'login')

      const { data, error } = await supabase.auth.signInWithPassword({
        email,
        password,
      })
      if (error) throw error
      user.value = data.user
      error.value = null
      return { error: null }
    } catch (error) {
      error.value = error instanceof Error ? error.message : 'Une erreur est survenue'
      return { error }
    }
  }

  async function signUp(email: string, password: string, recaptchaToken: string) {
    try {
      // Vérifier le token reCAPTCHA
      await verifyRecaptcha(recaptchaToken, 'signup')

      const { data, error } = await supabase.auth.signUp({
        email,
        password,
      })
      if (error) throw error
      error.value = null
      return { error: null }
    } catch (error) {
      error.value = error instanceof Error ? error.message : 'Une erreur est survenue'
      return { error }
    }
  }

  async function signOut() {
    try {
      const { error } = await supabase.auth.signOut()
      if (error) throw error
      user.value = null
      error.value = null
    } catch (error) {
      console.error('Error signing out:', error)
      error.value = error instanceof Error ? error.message : 'Une erreur est survenue'
    }
  }

  return {
    user,
    loading,
    error,
    init,
    signIn,
    signUp,
    signOut,
  }
}) 