-- Schema Base de Datos Zellfy.ai
-- MySQL 8.0+

CREATE DATABASE IF NOT EXISTS zellfy CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE zellfy;

-- Tabla de Leads
CREATE TABLE leads (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL,
  phone VARCHAR(50),
  company VARCHAR(255),
  source VARCHAR(100) COMMENT 'Origen: google, meta, whatsapp, web, etc',
  status ENUM('nuevo','contactado','calificado','propuesta','negociacion','cerrado','descartado') DEFAULT 'nuevo',
  assigned_to INT NULL COMMENT 'ID del usuario asignado',
  notes TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_status (status),
  INDEX idx_source (source),
  INDEX idx_created (created_at)
);

-- Tabla de Planes
CREATE TABLE plans (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  slug VARCHAR(100) UNIQUE NOT NULL,
  description TEXT,
  price DECIMAL(10,2) NOT NULL,
  currency VARCHAR(3) DEFAULT 'USD',
  features JSON COMMENT 'Características del plan en formato JSON',
  max_users INT DEFAULT 1,
  max_leads INT DEFAULT 0 COMMENT '0 = ilimitado',
  is_active BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabla de Usuarios
CREATE TABLE users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  email VARCHAR(255) UNIQUE NOT NULL,
  password VARCHAR(255) NOT NULL,
  role ENUM('admin','manager','agent') DEFAULT 'agent',
  phone VARCHAR(50),
  is_active BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Tabla de Campañas
CREATE TABLE campaigns (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  platform VARCHAR(100) COMMENT 'google, meta, linkedin, etc',
  budget DECIMAL(12,2),
  start_date DATE,
  end_date DATE,
  status ENUM('draft','active','paused','completed') DEFAULT 'draft',
  created_by INT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE CASCADE
);

-- Tabla de Interacciones (Seguimiento)
CREATE TABLE interactions (
  id INT AUTO_INCREMENT PRIMARY KEY,
  lead_id INT NOT NULL,
  user_id INT NOT NULL,
  type ENUM('call','email','whatsapp','meeting','note') NOT NULL,
  content TEXT,
  interaction_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (lead_id) REFERENCES leads(id) ON DELETE CASCADE,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Datos Iniciales de Planes
INSERT INTO plans (name, slug, description, price, features, max_users, max_leads) VALUES
('Starter', 'starter', 'Ideal para emprendedores y equipos pequeños', 49.00, '["Hasta 500 leads/mes", "2 usuarios", "Integraciones básicas", "Soporte email", "Dashboard básico"]', 2, 500),
('Pro', 'pro', 'Para equipos en crecimiento', 149.00, '["Leads ilimitados", "10 usuarios", "Todas las integraciones", "Soporte prioritario", "IA y análisis predictivo", "Automatizaciones avanzadas"]', 10, 0),
('Enterprise', 'enterprise', 'Soluciones a medida para grandes empresas', 0.00, '["Todo de Pro +", "Usuarios ilimitados", "API personalizada", "Infraestructura dedicada", "Onboarding personalizado", "Account manager dedicado"]', 0, 0);

-- Usuario Admin por defecto (password: admin123 - cambiar en producción)
INSERT INTO users (name, email, password, role) VALUES
('Admin Zellfy', 'admin@zellfy.ai', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'admin');
