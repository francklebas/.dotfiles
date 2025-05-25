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

  async function signIn(email: string, password: string) {
    try {
      const { data, error } = await supabase.auth.signInWithPassword({
        email,
        password,
      })
      if (error) throw error
      user.value = data.user
      return { error: null }
    } catch (error) {
      return { error }
    }
  }

  async function signUp(email: string, password: string) {
    try {
      const { data, error } = await supabase.auth.signUp({
        email,
        password,
      })
      if (error) throw error
      return { error: null }
    } catch (error) {
      return { error }
    }
  }

  async function signOut() {
    try {
      const { error } = await supabase.auth.signOut()
      if (error) throw error
      user.value = null
    } catch (error) {
      console.error('Error signing out:', error)
    }
  }

  return {
    user,
    loading,
    init,
    signIn,
    signUp,
    signOut,
  }
}) 