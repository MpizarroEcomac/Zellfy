/** @type {import('tailwindcss').Config} */
export default {
  content: [
    './src/**/*.{astro,html,js,jsx,md,mdx,svelte,ts,tsx,vue}',
    'node_modules/flowbite/**/*.{js,jsx,ts,tsx}'
  ],
  theme: {
    extend: {
      colors: {
        'blue-electric': '#00BFFF',
        'green-mint': '#00C48C',
        'violet-digital': '#6C63FF',
        'gray-smoke': '#F5F6FA',
      },
      fontFamily: {
        primary: ['Poppins', 'sans-serif'],
        secondary: ['Inter', 'sans-serif'],
      },
    },
  },
  plugins: [
    require('flowbite/plugin')
  ],
  darkMode: 'class',
}
