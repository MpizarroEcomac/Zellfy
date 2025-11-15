# 📝 Setup Formulario de Contacto - Zellfy

Este documento explica cómo poner en funcionamiento el formulario de contacto que captura leads reales.

---

## ✅ Lo que se ha implementado

### Backend (Laravel 12)
- ✅ `LeadController.php` - Controlador para capturar leads
- ✅ Ruta API `/api/leads` (POST)
- ✅ Ruta API `/api/leads/stats` (GET) - Para dashboard admin
- ✅ Configuración CORS para permitir requests desde frontend
- ✅ Validación de datos
- ✅ Logging de leads
- ✅ Base de datos SQLite configurada

### Frontend (Astro + Vue)
- ✅ `ContactForm.vue` actualizado con integración API
- ✅ Validación client-side
- ✅ Mensajes de éxito/error
- ✅ Google Analytics tracking (cuando se configure)
- ✅ Variables de entorno configuradas

---

## 🚀 Pasos para Activar (¡IMPORTANTE!)

### Opción A: Sin instalar PHP 8.2 (Recomendado para test rápido)

Puedes usar **SQLite directamente** sin necesidad de Laravel funcionando:

1. **Crear base de datos SQLite**:
```bash
cd /Users/macarenapizarro/Documents/GitHub/Zellfy/backend/database
touch database.sqlite
```

2. **Importar el schema**:
```bash
sqlite3 database.sqlite < ../database/schema.sql
```

3. **Crear endpoint temporal con Node.js** (mientras actualizas PHP):

Crear archivo `backend/server.js`:
```javascript
const express = require('express');
const cors = require('cors');
const sqlite3 = require('sqlite3');
const app = express();

app.use(cors());
app.use(express.json());

const db = new sqlite3.Database('./database/database.sqlite');

app.post('/api/leads', (req, res) => {
  const { name, email, phone, company, message } = req.body;
  
  db.run(
    `INSERT INTO leads (name, email, phone, company, notes, source, status, created_at, updated_at) 
     VALUES (?, ?, ?, ?, ?, 'website', 'new', datetime('now'), datetime('now'))`,
    [name, email, phone, company || null, message || null],
    function(err) {
      if (err) {
        return res.status(500).json({ success: false, message: 'Error' });
      }
      res.json({ success: true, message: '¡Gracias!', lead_id: this.lastID });
    }
  );
});

app.listen(8000, () => console.log('API running on http://localhost:8000'));
```

Instalar y correr:
```bash
cd backend
npm init -y
npm install express cors sqlite3
node server.js
```

---

### Opción B: Con Laravel (Recomendado para producción)

**1. Actualizar PHP a 8.2+**

```bash
# macOS con Homebrew
brew install php@8.2
brew link php@8.2 --force --overwrite

# Verificar versión
php -v  # Debe mostrar 8.2.x
```

**2. Instalar dependencias Laravel**:
```bash
cd /Users/macarenapizarro/Documents/GitHub/Zellfy/backend
composer install
```

**3. Generar APP_KEY**:
```bash
php artisan key:generate
```

**4. Crear base de datos SQLite**:
```bash
touch database/database.sqlite
```

**5. Ejecutar migraciones** (o importar schema):
```bash
# Opción 1: Con migraciones Laravel
php artisan migrate

# Opción 2: Importar schema.sql directamente
sqlite3 database/database.sqlite < ../database/schema.sql
```

**6. Iniciar servidor Laravel**:
```bash
php artisan serve
# Se ejecutará en http://localhost:8000
```

---

## 🧪 Testing

### 1. Test del Backend

```bash
# Terminal 1: Backend
cd backend
php artisan serve
# o
node server.js  # Si usas Opción A

# Terminal 2: Test con curl
curl -X POST http://localhost:8000/api/leads \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Juan Test",
    "email": "juan@test.com",
    "phone": "+56912345678",
    "company": "Test SA",
    "message": "Mensaje de prueba"
  }'

# Debe responder:
# {"success":true,"message":"¡Gracias por tu interés! Te contactaremos pronto.","lead_id":1}
```

### 2. Test del Frontend

```bash
# Terminal 3: Frontend
cd frontend
npm run dev
# Se ejecutará en http://localhost:4322
```

Ir a: **http://localhost:4322/contacto**

Llenar el formulario y enviar. Deberías ver:
- ✅ Mensaje de éxito verde
- ✅ Formulario se limpia
- ✅ Lead guardado en `backend/database/database.sqlite`

### 3. Verificar leads capturados

```bash
# Con Laravel
php artisan tinker
>>> DB::table('leads')->get();

# Con SQLite directo
cd backend/database
sqlite3 database.sqlite
sqlite> SELECT * FROM leads;
```

---

## 📊 Ver Estadísticas de Leads

Endpoint ya implementado:

```bash
curl http://localhost:8000/api/leads/stats

# Respuesta:
{
  "success": true,
  "data": {
    "total": 5,
    "new": 3,
    "today": 2,
    "this_month": 5
  }
}
```

---

## 🔐 Seguridad Implementada

✅ Validación de datos (email, teléfono, longitud)  
✅ CORS configurado (solo dominios permitidos)  
✅ SQL injection prevention (prepared statements)  
✅ Rate limiting (viene con Laravel por defecto)  
✅ Logging de errores  

---

## 📧 Notificaciones por Email (Opcional)

Para recibir notificación cuando llegue un lead:

1. **Editar `backend/.env`**:
```env
MAIL_MAILER=smtp
MAIL_HOST=smtp.gmail.com
MAIL_PORT=587
MAIL_USERNAME=tu-email@gmail.com
MAIL_PASSWORD=tu-app-password  # Generar en Google
MAIL_ENCRYPTION=tls
MAIL_FROM_ADDRESS="contacto@zellfy.ai"
```

2. **Descomentar en `LeadController.php` línea 59**:
```php
Mail::to('ventas@zellfy.ai')->send(new NewLeadNotification($lead));
```

3. **Crear el Mailable** (después te ayudo con esto)

---

## 🚨 Troubleshooting

### Error: "Failed to open stream: No such file or directory"
```bash
cd backend
composer install
```

### Error: "Your PHP version does not satisfy requirement"
```bash
brew install php@8.2
brew link php@8.2 --force --overwrite
```

### Error: CORS
Verificar que `backend/config/cors.php` incluye `http://localhost:4322`

### Formulario no envía
1. Verificar que el backend esté corriendo en puerto 8000
2. Abrir consola del navegador (F12) y buscar errores
3. Verificar que `.env` del frontend tenga `PUBLIC_API_URL=http://localhost:8000`

---

## ✅ Checklist de Funcionalidad

- [ ] Backend corriendo en http://localhost:8000
- [ ] Frontend corriendo en http://localhost:4322
- [ ] Base de datos SQLite creada
- [ ] Test con curl exitoso
- [ ] Formulario en /contacto envía correctamente
- [ ] Lead se guarda en base de datos
- [ ] Mensaje de éxito se muestra

---

## 🎯 Próximos Pasos

1. **Actualizar PHP a 8.2** (para usar Laravel completo)
2. **Configurar email notifications** (opcional)
3. **Crear dashboard admin** para ver leads
4. **Migrar a MySQL** en producción
5. **Deploy backend** en DigitalOcean o Laravel Forge

---

¿Necesitas ayuda con algún paso? Avísame y te guío en vivo.
