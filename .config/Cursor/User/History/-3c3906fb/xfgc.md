# FocusFlow

FocusFlow est une application web dédiée au bien-être mental, permettant de suivre son état émotionnel, gérer son stress et améliorer sa concentration.

## Fonctionnalités

- Authentification sécurisée
- Suivi de l'état émotionnel
- Gestion des tâches quotidiennes
- Statistiques personnalisées

## Prérequis

- Node.js (v16 ou supérieur)
- npm ou yarn
- Compte Supabase

## Installation

1. Cloner le dépôt :
```bash
git clone https://github.com/votre-username/focus-flow.git
cd focus-flow
```

2. Installer les dépendances :
```bash
npm install
# ou
yarn install
```

3. Créer un fichier `.env` à la racine du projet avec les variables d'environnement nécessaires :
```env
VITE_SUPABASE_URL=votre-url-supabase
VITE_SUPABASE_ANON_KEY=votre-clé-anon-supabase
```

4. Lancer l'application en mode développement :
```bash
npm run dev
# ou
yarn dev
```

## Structure du projet

```
focus-flow/
├── src/
│   ├── assets/         # Fichiers statiques
│   ├── components/     # Composants réutilisables
│   ├── stores/         # Stores Pinia
│   ├── views/          # Pages de l'application
│   ├── router/         # Configuration des routes
│   ├── App.vue         # Composant principal
│   └── main.ts         # Point d'entrée
├── public/             # Fichiers publics
├── index.html          # Template HTML
└── package.json        # Dépendances et scripts
```

## Technologies utilisées

- Vue 3 avec TypeScript
- Composition API
- Vue Router
- Pinia
- Supabase
- TailwindCSS
- DaisyUI

## Licence

MIT 