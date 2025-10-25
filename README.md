# Zellfy.ai — Plataforma Inteligente de Ventas

> **Conecta. Gestiona. Cierra.**

Zellfy.ai es un ecosistema completo para la gestión y automatización de procesos comerciales, construido con **Astro + Vue** en el frontend y **Laravel** en el backend.

---

## 🏗️ Arquitectura del Proyecto

```
/Zellfy
├── frontend/          # Sitio web público (Astro + Vue + TailwindCSS)
├── backend/           # API REST (Laravel 11 + MySQL)
├── database/          # Esquemas SQL y migraciones
└── docs/              # Documentación técnica y de marca
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
| **Frontend** | Astro 4.x + Vue 3 + TailwindCSS 4 |
| **Backend** | Laravel 11 (PHP 8.2+) |
| **Base de Datos** | MySQL 8.0+ |
| **Hosting Sugerido** | Vercel (frontend) + DigitalOcean (backend) |

---

## 🚀 Instalación y Configuración

### Frontend (Astro + Vue)

```powershell
cd frontend
npm install
npm run dev
```

El servidor de desarrollo estará disponible en `http://localhost:4321`

#### Comandos disponibles:
- `npm run dev` — Servidor de desarrollo
- `npm run build` — Construir para producción
- `npm run preview` — Previsualizar build de producción

### Backend (Laravel)

**Requisitos previos:**
- PHP 8.2+
- Composer
- MySQL 8.0+

```powershell
cd backend
composer install
cp .env.example .env
php artisan key:generate
php artisan migrate --seed
php artisan serve
```

La API estará disponible en `http://localhost:8000`

### Base de Datos

Importar el esquema inicial:

```powershell
mysql -u root -p < database/schema.sql
```

---

## 📄 Páginas del Sitio

1. **Inicio** (`/`) — Presentación y propuesta de valor
2. **Cómo Funciona** (`/como-funciona`) — Timeline de 8 etapas del proceso
3. **Soluciones** (`/soluciones`) — Zellfy (CRM) y Zellflow (Automatización)
4. **Precios** (`/pricing`) — Planes: Starter, Pro, Enterprise
5. **Casos de Éxito** (`/casos`) — Ecomac, Creces y otros clientes
6. **Contacto** (`/contacto`) — Formulario de contacto integrado con CRM

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

## 📚 Documentación Adicional

Consulta `/docs/Zellfy_Website_Blueprint.md` para detalles técnicos completos.

---

## 👥 Equipo

Desarrollado para **Zellfy.ai** — Plataforma Inteligente de Ventas

---

## 📄 Licencia

Propietario — Todos los derechos reservados © 2025 Zellfy.ai
