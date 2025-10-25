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

- **Páginas principales**:
  - `/` - Inicio con hero y beneficios
  - `/como-funciona` - Timeline del journey del cliente
  - `/soluciones` - Zellfy (CRM) y Zellflow (automatización)
  - `/pricing` - Planes comparativos
  - `/casos` - Casos de éxito
  - `/contacto` - Formulario de contacto

### Backend (Laravel)

El directorio `backend/` está planificado pero aún no implementado. Cuando se desarrolle:
- Laravel 11 con PHP 8.2+
- API REST en `/api/*` endpoints
- MySQL 8.0+ como base de datos
- Endpoints planificados: `/api/pricing`, `/api/contact`, `/api/casos`, `/api/leads`, `/api/blog`

---

## Comandos Esenciales

### Frontend (Astro)

**Desarrollo:**
```powershell
cd frontend
npm install           # Instalar dependencias
npm run dev          # Servidor de desarrollo en http://localhost:4321
```

**Build y Deploy:**
```powershell
npm run build        # Construir para producción (debe ejecutarse antes de commits)
npm run preview      # Previsualizar build de producción
```

**Testing:**
```powershell
npm run test         # Ejecutar pruebas del frontend
```

### Backend (Laravel - cuando esté implementado)

```powershell
cd backend
composer install
cp .env.example .env
php artisan key:generate
php artisan migrate --seed
php artisan serve    # API en http://localhost:8000
php artisan test     # Ejecutar pruebas
```

### Base de Datos

```powershell
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
2. El backend Laravel, cuando esté implementado, requerirá `php artisan test` antes de commits

### Servidor en Background (PowerShell)

Iniciar el servidor como job en background para liberar la terminal:

```powershell
cd frontend
Start-Job -ScriptBlock { npm run dev }
Get-Job  # Verificar estado
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
- 6 páginas principales (index, como-funciona, soluciones, pricing, casos, contacto)
- Layout base con navegación y footer
- Sistema de diseño con variables CSS
- Esquema de base de datos MySQL completo

### 🚧 En Desarrollo
- Componentes Vue interactivos (formularios, animaciones)
- Backend Laravel completo
- API REST endpoints
- Sistema CRM integrado
- Integraciones externas (Google, Meta, WhatsApp)

### 📋 Pendiente
- Sistema de blog con MDX
- Autenticación y roles de usuario
- Dashboard de analytics
- Tests automatizados
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

## Troubleshooting en Windows/PowerShell

### Error: "npm no reconocido como comando"
```powershell
# Verificar instalación de Node.js
node --version
npm --version

# Si no está instalado, descargar desde: https://nodejs.org/
```

### Error: "Permisos denegados" al ejecutar scripts
```powershell
# Ejecutar PowerShell como Administrador
# Cambiar política de ejecución (solo una vez)
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

### Error: "Puerto 4321 ya en uso"
```powershell
# Encontrar proceso usando el puerto
Get-NetTCPConnection -LocalPort 4321 | Select-Object OwningProcess

# Detener el proceso (reemplazar PID con el número del proceso)
Stop-Process -Id PID -Force

# O usar otro puerto
npm run dev -- --port 3000
```

### Limpiar cache y reinstalar dependencias
```powershell
cd frontend
Remove-Item -Recurse -Force node_modules, package-lock.json
npm install
```

### Servidor no accesible desde otros dispositivos
```powershell
# Ejecutar con host 0.0.0.0
npm run dev -- --host 0.0.0.0

# Acceder desde: http://TU_IP_LOCAL:4321
```

---

## Documentación Adicional

Consultar `/docs/Zellfy_Website_Blueprint.md` para especificaciones técnicas completas del proyecto, incluyendo:
- Arquitectura detallada
- Estructura de base de datos
- Endpoints API planificados
- Casos de uso por industria
- Integraciones y seguridad
- Copy de marca y contenido
