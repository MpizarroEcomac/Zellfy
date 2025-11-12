# WARP.md

Este archivo proporciona orientación a WARP (warp.dev) cuando trabaja con código en este repositorio.

---

## Arquitectura del Proyecto

Zellfy.ai es una plataforma de gestión de ventas con arquitectura monorepo que separa frontend y backend:

```
/Zellfy
├── frontend/          # Sitio web público (Astro + Vue + TailwindCSS)
├── backend/           # API REST Laravel 11 (en desarrollo)
├── database/          # Esquemas SQL y migraciones
└── docs/              # Documentación técnica y branding
```

### Frontend (Astro + Vue)

- **Framework**: Astro 5.15 con integración Vue 3
- **Estilos**: TailwindCSS 4.1 mediante plugin Vite
- **Estructura**:
  - `src/pages/`: Rutas del sitio (file-based routing)
  - `src/layouts/`: Layout base compartido (BaseLayout.astro)
  - `src/components/`: Componentes Vue y Astro reutilizables
  - `src/styles/`: Variables CSS y estilos globales
  - `src/content/`: Contenido estructurado

- **Páginas implementadas**:
  - `/` - Inicio con hero y beneficios
  - `/como-funciona` - Timeline del journey del cliente
  - `/soluciones` - Zellfy (CRM) y Zellflow (automatización)
  - `/pricing` - Planes comparativos
  - `/casos` - Casos de éxito
  - `/contacto` - Formulario de contacto
  - `/nosotros` - Sobre la empresa
  - `/valores` - Valores corporativos
  - `/integraciones` - Integraciones disponibles
  - `/blog` - Blog y artículos

### Backend (Laravel)

- **Framework**: Laravel 12 con PHP 8.2+
- **Base de datos**: MySQL 8.0+ (configurable con SQLite para desarrollo)
- **API REST**: Endpoints en `/api/*`
- **Estructura**:
  - `app/`: Lógica de aplicación (Models, Controllers, Services)
  - `routes/`: Definición de rutas (web.php, api.php)
  - `database/`: Migraciones, seeders y factories
  - `tests/`: Pruebas unitarias y de integración
- **Comandos útiles de Composer**:
  - `composer setup`: Instalación completa (dependencias + migración + build)
  - `composer dev`: Servidor + queue + logs + vite (desarrollo completo)
  - `composer test`: Ejecutar suite de pruebas

---

## Comandos Esenciales

### Frontend (Astro)

**Desarrollo:**
```bash
cd frontend
npm install           # Instalar dependencias
npm run dev          # Servidor de desarrollo en http://localhost:4321
```

**Build y Deploy:**
```bash
npm run build        # Construir para producción (debe ejecutarse antes de commits)
npm run preview      # Previsualizar build de producción
```

**Nota**: No hay comando `npm run test` configurado actualmente en el frontend.

### Backend (Laravel)

**Setup inicial:**
```bash
cd backend
composer setup       # Instala dependencias, copia .env, genera key, migra DB, instala npm y builda
```

**Desarrollo:**
```bash
composer dev         # Inicia servidor + queue + logs + vite simultáneamente
# O manualmente:
php artisan serve    # API en http://localhost:8000
```

**Otros comandos:**
```bash
composer install     # Solo instalar dependencias
php artisan migrate  # Ejecutar migraciones
php artisan db:seed  # Poblar base de datos
composer test        # Ejecutar suite de pruebas (alias de php artisan test)
```

### Base de Datos

```bash
mysql -u root -p < database/schema.sql
```

---

## Sistema de Diseño

**Paleta de colores** (variables CSS en BaseLayout.astro):
- `--color-blue-electric`: #00BFFF (azul eléctrico)
- `--color-green-mint`: #00C48C (verde menta)
- `--color-violet`: #6C63FF (violeta digital)
- `--color-gray-smoke`: #F5F6FA (gris humo)

**Tipografía**:
- Principal: Manrope (`--font-primary`)
- Alternativa: Poppins (`--font-secondary`)

**Slogan oficial**: "Conecta. Gestiona. Cierra."

---

## Convenciones de Código

### Estructura de Componentes

- **Archivos `.astro`**: Para páginas y layouts estáticos
- **Componentes Vue**: Para interactividad y estado reactivo
- **CSS**: Utilizar clases Tailwind + variables CSS personalizadas

### Organización de Estilos

Los estilos globales están en `BaseLayout.astro` bajo la etiqueta `<style is:global>`. Usar variables CSS para colores de marca en lugar de valores hardcodeados.

### Idioma

Todo el contenido y UI debe estar en **español neutro**.

---

## Flujo de Desarrollo

### Antes de Commits

1. Ejecutar `npm run build` en frontend/ para verificar que no hay errores de compilación
2. Ejecutar `composer test` en backend/ para verificar que las pruebas pasen

### Servidor en Background (macOS/zsh)

Iniciar el servidor en background para liberar la terminal:

**Frontend:**
```bash
cd frontend
npm run dev &
# O con nohup para mantenerlo después de cerrar terminal:
nohup npm run dev > /dev/null 2>&1 &
```

**Backend (recomendado usar composer dev que maneja múltiples procesos):**
```bash
cd backend
composer dev  # Esto ya maneja servidor, queue, logs y vite
```

### Análisis de Errores

Revisar la consola del navegador en el servidor activo de background, no en instancias locales de prueba.

---

## Estructura de Commits

Usar convenciones de commits semánticos:

```
<tipo>: <descripción breve>

<cuerpo opcional explicando qué y por qué>

<footer opcional: Closes #ID o BREAKING CHANGE>
```

**Tipos comunes**:
- `feat`: Nueva funcionalidad
- `fix`: Corrección de error
- `docs`: Documentación
- `style`: Formato sin cambios de lógica
- `refactor`: Cambios sin alterar funcionalidad
- `test`: Pruebas
- `chore`: Mantenimiento

---

## Integraciones Planificadas

El proyecto está diseñado para conectarse con:
- Google Ads / Meta Ads (captación)
- WhatsApp Business API
- CRM externos (Salesforce, HubSpot)
- APIs bancarias y Clave Única (Chile)
- Email SMTP

Configuración en `backend/.env` (cuando se implemente).

---

## Hosting y Deploy

- **Frontend**: Vercel (comando build: `npm run build`, output: `dist/`)
- **Backend**: DigitalOcean o Laravel Forge (cuando se implemente)

---

## Esquema de Base de Datos

El archivo `database/schema.sql` define la estructura MySQL completa:

**Tablas principales**:
- `leads` - Captura y gestión de prospectos (name, email, phone, company, source, status, assigned_to, notes)
- `plans` - Planes de precios (name, slug, description, price, features JSON, max_users, max_leads)
- `users` - Usuarios del sistema (name, email, password, role: admin/manager/agent)
- `campaigns` - Campañas publicitarias (name, platform, budget, start_date, end_date, status)
- `interactions` - Seguimiento de comunicaciones (lead_id, user_id, type: call/email/whatsapp/meeting/note, content)

**Datos iniciales**:
- Planes Starter ($49), Pro ($149), Enterprise (custom)
- Usuario admin por defecto: `admin@zellfy.ai` / `admin123` (cambiar en producción)

---

## Variables de Entorno

Cuando se implemente el backend Laravel, configurar `backend/.env`:

```env
# Aplicación
APP_NAME=Zellfy.ai
APP_ENV=production
APP_KEY=base64:xxx  # Generar con: php artisan key:generate

# Base de Datos
DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=zellfy
DB_USERNAME=root
DB_PASSWORD=secret

# Email (SMTP)
MAIL_MAILER=smtp
MAIL_HOST=smtp.gmail.com
MAIL_PORT=587
MAIL_USERNAME=contacto@zellfy.ai
MAIL_PASSWORD=********
MAIL_FROM_ADDRESS=contacto@zellfy.ai
MAIL_FROM_NAME="${APP_NAME}"

# APIs Externas
API_GOOGLE_KEY=xxxxx
API_META_TOKEN=xxxxx
WHATSAPP_API_TOKEN=xxxxx
```

---

## Estado del Proyecto

### ✅ Implementado
- Estructura frontend Astro + Vue + TailwindCSS
- 10 páginas (index, como-funciona, soluciones, pricing, casos, contacto, nosotros, valores, integraciones, blog)
- Layout base con navegación y footer
- Sistema de diseño con variables CSS
- Esquema de base de datos MySQL completo
- Backend Laravel 12 con estructura base
- Comandos composer automatizados (setup, dev, test)

### 🚧 En Desarrollo
- Componentes Vue interactivos (formularios, animaciones)
- API REST endpoints
- Sistema CRM integrado
- Integraciones externas (Google, Meta, WhatsApp)
- Contenido del blog

### 📋 Pendiente
- Sistema de blog con contenido MDX
- Autenticación y roles de usuario
- Dashboard de analytics
- Tests automatizados frontend
- SEO avanzado (Schema.org, sitemap dinámico)
- Google Analytics 4 + Meta Pixel

---

## Assets y Recursos

**Directorio público** (`frontend/public/`):
- `favicon.svg` - Icono del sitio
- Assets estáticos adicionales se colocarán aquí

**Imágenes y recursos** deben almacenarse en:
- `frontend/src/assets/` - Imágenes procesadas por Vite
- `frontend/public/` - Assets públicos sin procesamiento

---

## Documentación Adicional

Consultar `/docs/Zellfy_Website_Blueprint.md` para especificaciones técnicas completas del proyecto, incluyendo:
- Arquitectura detallada
- Estructura de base de datos
- Endpoints API planificados
- Casos de uso por industria
- Integraciones y seguridad
- Copy de marca y contenido
