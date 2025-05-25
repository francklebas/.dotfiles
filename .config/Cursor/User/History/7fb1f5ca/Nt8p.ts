import { ref, onMounted } from 'vue'

declare global {
  interface Window {
    grecaptcha: {
      ready: (callback: () => void) => void
      execute: (siteKey: string, options: { action: string }) => Promise<string>
    }
  }
}

export function useRecaptchaV3() {
  const isReady = ref(false)
  const siteKey = import.meta.env.VITE_RECAPTCHA_SITE_KEY

  onMounted(() => {
    // Charger le script reCAPTCHA
    const script = document.createElement('script')
    script.src = `https://www.google.com/recaptcha/api.js?render=${siteKey}`
    script.async = true
    script.defer = true
    document.head.appendChild(script)

    // Attendre que reCAPTCHA soit prêt
    window.grecaptcha.ready(() => {
      isReady.value = true
    })
  })

  async function executeRecaptcha(action: string): Promise<string> {
    if (!isReady.value) {
      throw new Error('reCAPTCHA n\'est pas encore prêt')
    }

    try {
      const token = await window.grecaptcha.execute(siteKey, { action })
      return token
    } catch (error) {
      console.error('Erreur lors de l\'exécution de reCAPTCHA:', error)
      throw new Error('Erreur lors de la vérification reCAPTCHA')
    }
  }

  return {
    executeRecaptcha,
    isReady
  }
} 