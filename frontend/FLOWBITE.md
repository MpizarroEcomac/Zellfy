# Integración de Flowbite en Zellfy.ai

## ¿Qué es Flowbite?

Flowbite es una librería de componentes de UI construida con Tailwind CSS. Proporciona componentes predefinidos listos para usar, como botones, modales, navbars, alertas, dropdowns, etc.

## Instalación Completada ✅

Los siguientes pasos ya han sido realizados:

1. **Instalación del paquete**: `npm install -D flowbite`
2. **Configuración de Tailwind** (`tailwind.config.mjs`):
   - Añadido `flowbite/plugin` a los plugins
   - Configurado content path: `node_modules/flowbite/**/*.{js,jsx,ts,tsx}`
   - Añadidas variables de color personalizadas
   - Habilitado dark mode

3. **Estilos CSS** (`src/styles/global.css`):
   - Añadidas directivas de Tailwind (@tailwind base, components, utilities)

4. **Script de Flowbite** (`src/layouts/BaseLayout.astro`):
   - Incluido CDN: `https://cdn.jsdelivr.net/npm/flowbite@2.5.2/dist/flowbite.min.js`

## Cómo Usar Componentes de Flowbite

### 1. En páginas `.astro`

```astro
---
// src/pages/mi-pagina.astro
import BaseLayout from '../layouts/BaseLayout.astro';
---

<BaseLayout title="Mi Página">
  <!-- Botón de Flowbite usando clases Tailwind -->
  <button type="button" class="text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 me-2 mb-2">
    Mi Botón Flowbite
  </button>

  <!-- Modal de Flowbite -->
  <button data-modal-target="defaultModal" data-modal-toggle="defaultModal" class="block text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center" type="button">
    Abrir Modal
  </button>

  <div id="defaultModal" tabindex="-1" aria-hidden="true" class="hidden overflow-y-auto overflow-x-hidden fixed top-0 right-0 left-0 z-50 justify-center items-center w-full md:inset-0 h-[calc(100%-1rem)] max-h-full">
    <div class="relative p-4 w-full max-w-2xl max-h-full">
      <div class="relative bg-white rounded-lg shadow">
        <div class="flex items-center justify-between p-4 md:p-5 border-b rounded-t">
          <h3 class="text-xl font-semibold text-gray-900">Mi Modal</h3>
          <button type="button" class="text-gray-400 bg-transparent hover:bg-gray-200 hover:text-gray-900 rounded-lg text-sm w-8 h-8 ms-auto inline-flex justify-center items-center" data-modal-hide="defaultModal">
            <svg class="w-3 h-3" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 14 14">
              <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="m1 1 6 6m0 0 6 6M7 7l6-6M7 7l-6 6"/>
            </svg>
          </button>
        </div>
        <div class="p-4 md:p-5 space-y-4">
          <p class="text-base leading-relaxed text-gray-500">Contenido del modal aquí</p>
        </div>
      </div>
    </div>
  </div>
</BaseLayout>
```

### 2. En componentes Vue

```vue
<!-- src/components/FlowbiteCard.vue -->
<template>
  <div class="max-w-sm p-6 bg-white border border-gray-200 rounded-lg shadow hover:shadow-lg transition-shadow">
    <h5 class="mb-2 text-2xl font-bold tracking-tight text-gray-900">
      <slot name="title" />
    </h5>
    <p class="mb-3 font-normal text-gray-700">
      <slot />
    </p>
    <a href="#" class="inline-flex items-center px-3 py-2 text-sm font-medium text-center text-white bg-blue-700 rounded-lg hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300">
      Más información
      <svg class="rtl:rotate-180 w-3.5 h-3.5 ms-2" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 14 10">
        <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M1 5h12m0 0L9 1m4 4L9 9"/>
      </svg>
    </a>
  </div>
</template>
```

### 3. Usa el componente personalizado

```astro
---
// src/pages/ejemplo.astro
import BaseLayout from '../layouts/BaseLayout.astro';
import FlowbiteButton from '../components/FlowbiteButton.vue';
---

<BaseLayout title="Ejemplo con Flowbite">
  <FlowbiteButton variant="primary">Botón Primario</FlowbiteButton>
  <FlowbiteButton variant="success">Botón Éxito</FlowbiteButton>
  <FlowbiteButton variant="danger">Botón Peligro</FlowbiteButton>
</BaseLayout>
```

## Colores Personalizados Disponibles

En `tailwind.config.mjs` se han añadido estos colores de Zellfy:

```tailwind
bg-blue-electric      /* #00BFFF */
bg-green-mint         /* #00C48C */
bg-violet-digital     /* #6C63FF */
bg-gray-smoke         /* #F5F6FA */
```

## Componentes Flowbite Recomendados

- **Buttons**: Botones estilizados
- **Cards**: Tarjetas de contenido
- **Modals**: Diálogos emergentes
- **Navbars**: Barras de navegación
- **Dropdowns**: Menús desplegables
- **Alerts**: Alertas y notificaciones
- **Tables**: Tablas con estilos
- **Forms**: Campos de formulario
- **Pagination**: Paginación

## Documentación Oficial

Visita [flowbite.com](https://flowbite.com) para ver más componentes y ejemplos.

## Verificación

✅ Build sin errores
✅ Servidor corriendo en background (Job3)
✅ Todos los estilos compilados correctamente
