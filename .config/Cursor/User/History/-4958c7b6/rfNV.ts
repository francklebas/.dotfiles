import { serve } from 'https://deno.land/std@0.168.0/http/server.ts'

// @ts-ignore
const RECAPTCHA_SECRET_KEY = Deno.env.get('RECAPTCHA_SECRET_KEY')

serve(async (req) => {
  const corsHeaders = {
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
    'Access-Control-Allow-Methods': 'POST, OPTIONS',
    'Content-Type': 'application/json',
  }

  if (req.method === 'OPTIONS') {
    return new Response('ok', { status: 200, headers: corsHeaders })
  }

  try {
    const { token, action } = await req.json()

    const response = await fetch('https://www.google.com/recaptcha/api/siteverify', {
      method: 'POST',
      headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
      body: new URLSearchParams({
        secret: RECAPTCHA_SECRET_KEY,
        response: token,
      }),
    })

    const data = await response.json()

    if (data.success && data.score >= 0.5 && data.action === action) {
      return new Response(JSON.stringify({ success: true }), { status: 200, headers: corsHeaders })
    } else {
      return new Response(JSON.stringify({ success: false, reason: 'reCAPTCHA check failed', details: data }), {
        status: 400,
        headers: corsHeaders,
      })
    }
  } catch (e) {
    return new Response(JSON.stringify({ success: false, reason: 'Unexpected error', error: String(e) }), {
      status: 500,
      headers: corsHeaders,
    })
  }
})
