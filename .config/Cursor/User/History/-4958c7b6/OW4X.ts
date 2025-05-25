import { serve } from 'https://deno.land/std@0.168.0/http/server.ts'

const RECAPTCHA_SECRET_KEY = Deno.env.get('RECAPTCHA_SECRET_KEY')

interface RecaptchaResponse {
  success: boolean
  score: number
  action: string
  challenge_ts: string
  hostname: string
  'error-codes'?: string[]
}

serve(async (req) => {
  try {
    const { token, action } = await req.json()

    if (!token || !action) {
      return new Response(
        JSON.stringify({ error: 'Token et action requis' }),
        { status: 400 }
      )
    }

    const response = await fetch('https://www.google.com/recaptcha/api/siteverify', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: `secret=${RECAPTCHA_SECRET_KEY}&response=${token}`,
    })

    const data: RecaptchaResponse = await response.json()

    if (!data.success) {
      return new Response(
        JSON.stringify({ 
          success: false,
          error: 'Vérification reCAPTCHA échouée',
          errorCodes: data['error-codes']
        }),
        { status: 400 }
      )
    }

    // Vérifier le score (0.5 est un seuil raisonnable)
    if (data.score < 0.5) {
      return new Response(
        JSON.stringify({ 
          success: false,
          error: 'Score reCAPTCHA trop bas',
          score: data.score
        }),
        { status: 400 }
      )
    }

    // Vérifier que l'action correspond
    if (data.action !== action) {
      return new Response(
        JSON.stringify({ 
          success: false,
          error: 'Action reCAPTCHA invalide'
        }),
        { status: 400 }
      )
    }

    return new Response(
      JSON.stringify({ success: true }),
      { status: 200 }
    )
  } catch (error) {
    return new Response(
      JSON.stringify({ 
        success: false,
        error: 'Erreur lors de la vérification reCAPTCHA'
      }),
      { status: 500 }
    )
  }
}) 