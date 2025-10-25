# Zellfy.ai — Plataforma Inteligente de Ventas

> **Conecta. Gestiona. Cierra.**

Zellfy.ai es un ecosistema completo para la gestión y automatización de procesos comerciales, construido con **Astro + Vue** en el frontend y **Laravel** en el backend.

[![License](https://img.shields.io/badge/license-Proprietary-red.svg)](LICENSE)
[![Astro](https://img.shields.io/badge/Astro-5.15-FF5D01?logo=astro)](https://astro.build)
[![Vue](https://img.shields.io/badge/Vue-3.5-4FC08D?logo=vue.js)](https://vuejs.org)
[![TailwindCSS](https://img.shields.io/badge/Tailwind-4.1-38B2AC?logo=tailwind-css)](https://tailwindcss.com)

---

## 🚀 Inicio Rápido

### Requisitos Previos

- **Node.js** 18+ y npm
- **PHP** 8.2+ y Composer (para backend)
- **MySQL** 8.0+ (para backend)
- **PowerShell** (Windows)

### Instalación

#### Frontend

```powershell
cd frontend
npm install
npm run dev
```

El sitio estará disponible en **http://localhost:4321**

#### Backend (Próximamente)

```powershell
cd backend
composer install
cp .env.example .env
php artisan key:generate
php artisan migrate --seed
php artisan serve
```

La API estará disponible en **http://localhost:8000**

---

## 🏗️ Arquitectura del Proyecto

```
/Zellfy
├── frontend/          # Sitio web público (Astro + Vue + TailwindCSS)
│   ├── src/
│   │   ├── pages/         # Rutas del sitio (file-based routing)
│   │   ├── layouts/       # Plantillas base compartidas
│   │   ├── components/    # Componentes Vue y Astro reutilizables
│   │   ├── assets/        # Imágenes y recursos procesados
│   │   └── styles/        # Estilos globales y variables CSS
│   ├── public/            # Assets estáticos (favicon, etc.)
│   └── package.json
│
├── backend/           # API REST (Laravel 11 + MySQL) - En desarrollo
│   ├── app/
│   ├── database/
│   ├── routes/
│   └── composer.json
│
├── database/          # Esquemas SQL y migraciones
│   └── schema.sql
│
└── docs/              # Documentación técnica y de marca
    └── Zellfy_Website_Blueprint.md
```

---

## 🎨 Identidad de Marca

### Paleta de Colores

- **Azul eléctrico:** `#00BFFF`
- **Verde menta:** `#00C48C`
- **Violeta digital:** `#6C63FF`
- **Gris humo:** `#F5F6FA`

### Tipografía

- **Principal:** Manrope
- **Alternativa:** Poppins

### Slogan

**"Conecta. Gestiona. Cierra."**

---

## ⚙️ Tecnologías

| Capa | Tecnología |
|------|------------|
| **Frontend** | Astro 5.x + Vue 3 + TailwindCSS 4 |
| **Backend** | Laravel 11 (PHP 8.2+) |
| **Base de Datos** | MySQL 8.0+ |
| **Hosting Sugerido** | Vercel (frontend) + DigitalOcean (backend) |

---

## 📄 Páginas del Sitio

| Ruta | Descripción |
|------|-------------|
| `/` | Presentación y propuesta de valor |
| `/como-funciona` | Timeline de 8 etapas del proceso |
| `/soluciones` | Zellfy (CRM) y Zellflow (Automatización) |
| `/pricing` | Planes: Starter, Pro, Enterprise |
| `/casos` | Casos de éxito (Ecomac, Creces, etc.) |
| `/contacto` | Formulario de contacto integrado con CRM |

---

## 🔌 Endpoints API (Backend Laravel)

| Método | Ruta | Descripción |
|--------|------|-------------|
| `GET` | `/api/pricing` | Lista de planes con precios |
| `POST` | `/api/contact` | Enviar formulario de contacto |
| `GET` | `/api/casos` | Casos de éxito |
| `POST` | `/api/leads` | Crear nuevo lead |
| `GET` | `/api/blog` | Artículos del blog |

---

## 🧪 Testing

### Frontend

```powershell
cd frontend
npm run test
```

### Backend

```powershell
cd backend
php artisan test
```

---

## 📦 Despliegue

### Frontend (Vercel)

1. Conectar repositorio en Vercel
2. Configurar directorio: `frontend/`
3. Comando build: `npm run build`
4. Directorio output: `dist/`

### Backend (DigitalOcean / Laravel Forge)

1. Configurar servidor con PHP 8.2+ y MySQL
2. Conectar repositorio
3. Configurar `.env` con credenciales de producción
4. Ejecutar `php artisan migrate --force`

---

## 🗄️ Base de Datos

### Tablas Principales

- **`leads`** - Gestión de prospectos y seguimiento
- **`plans`** - Planes de suscripción (Starter, Pro, Enterprise)
- **`users`** - Usuarios y roles (admin, manager, agent)
- **`campaigns`** - Campañas publicitarias
- **`interactions`** - Historial de comunicaciones

### Importar Esquema

```powershell
mysql -u root -p < database/schema.sql
```

---

## 📚 Documentación

- **[Documentación Técnica Completa](docs/Zellfy_Website_Blueprint.md)** - Blueprint detallado del proyecto
- **[Guía de Desarrollo para WARP](WARP.md)** - Instrucciones para IA agents

---

## 🛠️ Comandos Disponibles

### Frontend

| Comando | Acción |
|---------|--------|
| `npm install` | Instalar dependencias |
| `npm run dev` | Servidor de desarrollo |
| `npm run build` | Build para producción |
| `npm run preview` | Previsualizar build |
| `npm run test` | Ejecutar pruebas |

### Backend (cuando esté implementado)

| Comando | Acción |
|---------|--------|
| `composer install` | Instalar dependencias |
| `php artisan serve` | Servidor de desarrollo |
| `php artisan test` | Ejecutar pruebas |
| `php artisan migrate` | Ejecutar migraciones |
| `php artisan db:seed` | Poblar base de datos |

---

## 🔒 Seguridad

- Middleware Laravel: `Auth`, `ThrottleRequests`, `Sanctum`
- Formularios protegidos con reCAPTCHA
- CORS habilitado para frontend Astro
- HTTPS obligatorio en producción

---

## 🤝 Contribución

Este es un proyecto propietario. Para contribuir:

1. Crear una rama feature: `git checkout -b feature/nueva-funcionalidad`
2. Commit con formato semántico: `feat: agregar formulario de contacto`
3. Ejecutar `npm run build` antes de hacer push
4. Crear Pull Request con descripción detallada

### Convención de Commits

```
<tipo>: <descripción breve>

<cuerpo opcional>

<footer opcional: Closes #ID>
```

**Tipos**: `feat`, `fix`, `docs`, `style`, `refactor`, `test`, `chore`

---

## 👥 Equipo

Desarrollado para **Zellfy.ai** — Plataforma Inteligente de Ventas

---

## 📄 Licencia

Propietario — Todos los derechos reservados © 2025 Zellfy.ai

---

## 🆘 Soporte

Para soporte técnico o consultas comerciales:

- **Email:** contacto@zellfy.ai
- **Documentación:** Ver `/docs/` para detalles técnicos
- **Issues:** Usar el sistema de issues de GitHub (repositorio privado)

---

**¿Listo para transformar tus ventas?** 🚀

Empieza hoy mismo y descubre cómo Zellfy.ai puede llevar tu negocio al siguiente nivel.
