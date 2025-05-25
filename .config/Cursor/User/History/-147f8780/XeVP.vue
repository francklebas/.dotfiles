<template>
  <div class="min-h-screen bg-base-100">
    <div class="navbar bg-base-200">
      <div class="flex-1">
        <router-link to="/app" class="btn btn-ghost normal-case text-xl font-heading">FocusFlow</router-link>
      </div>
      <div class="flex-none">
        <button @click="handleLogout" class="btn btn-ghost">Déconnexion</button>
      </div>
    </div>

    <div class="container mx-auto px-4 py-8">
      <div class="text-center">
        <h1 class="text-3xl font-bold mb-4 font-heading">Bienvenue, {{ user?.email }}</h1>
        <p class="text-lg mb-8">Votre espace personnel pour le bien-être mental</p>
      </div>

      <!-- TODO: Ajouter les fonctionnalités principales ici -->
      <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        <div class="card bg-base-200 shadow-xl">
          <div class="card-body">
            <h2 class="card-title font-heading">État du jour</h2>
            <p>En cours de développement...</p>
          </div>
        </div>
        <div class="card bg-base-200 shadow-xl">
          <div class="card-body">
            <h2 class="card-title font-heading">Tâches</h2>
            <p>En cours de développement...</p>
          </div>
        </div>
        <div class="card bg-base-200 shadow-xl">
          <div class="card-body">
            <h2 class="card-title font-heading">Statistiques</h2>
            <p>En cours de développement...</p>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { useRouter } from 'vue-router'
import { useAuthStore } from '@/stores/auth'

const router = useRouter()
const authStore = useAuthStore()
const user = authStore.user

async function handleLogout() {
  await authStore.signOut()
  router.push('/')
}
</script> 