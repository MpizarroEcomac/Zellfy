<template>
  <div style="width: 100%;">
    <form @submit.prevent="handleSubmit" style="display: flex; flex-direction: column; gap: 1.5rem;">
      <!-- Fila 1: Nombre y Empresa -->
      <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1rem;">
        <!-- Nombre -->
        <div>
          <label style="display: block; margin-bottom: 0.5rem; font-size: 0.875rem; font-weight: 500; color: #111827;">Nombre completo</label>
        <input 
          v-model="formData.name" 
          type="text" 
          placeholder="Juan García"
          style="width: 100%; padding: 0.75rem; color: #111827; border: 1px solid #d1d5db; border-radius: 0.5rem; background-color: #f9fafb; font-size: 0.875rem; transition: all 0.2s ease;"
          @blur="onBlur('name', $event)"
          @focus="(e) => { e.target.style.borderColor = '#3b82f6'; e.target.style.boxShadow = '0 0 0 3px rgba(59, 130, 246, 0.1)'; }"
        />
          <p v-if="errors.name" style="margin-top: 0.5rem; font-size: 0.875rem; color: #dc2626;">{{ errors.name }}</p>
        </div>

        <!-- Empresa -->
        <div>
          <label style="display: block; margin-bottom: 0.5rem; font-size: 0.875rem; font-weight: 500; color: #111827;">Empresa</label>
        <input 
          v-model="formData.company" 
          type="text" 
          placeholder="Mi Empresa S.A."
          style="width: 100%; padding: 0.75rem; color: #111827; border: 1px solid #d1d5db; border-radius: 0.5rem; background-color: #f9fafb; font-size: 0.875rem; transition: all 0.2s ease;"
          @blur="onBlur('company', $event)"
          @focus="(e) => { e.target.style.borderColor = '#3b82f6'; e.target.style.boxShadow = '0 0 0 3px rgba(59, 130, 246, 0.1)'; }"
        />
          <p v-if="errors.company" style="margin-top: 0.5rem; font-size: 0.875rem; color: #dc2626;">{{ errors.company }}</p>
        </div>
      </div>

      <!-- Fila 2: Email y Teléfono -->
      <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1rem;">
        <!-- Email -->
        <div>
          <label style="display: block; margin-bottom: 0.5rem; font-size: 0.875rem; font-weight: 500; color: #111827;">Correo electrónico</label>
        <input 
          v-model="formData.email" 
          type="email" 
          placeholder="contacto@empresa.com"
          style="width: 100%; padding: 0.75rem; color: #111827; border: 1px solid #d1d5db; border-radius: 0.5rem; background-color: #f9fafb; font-size: 0.875rem; transition: all 0.2s ease;"
          @blur="onBlur('email', $event)"
          @focus="(e) => { e.target.style.borderColor = '#3b82f6'; e.target.style.boxShadow = '0 0 0 3px rgba(59, 130, 246, 0.1)'; }"
        />
          <p v-if="errors.email" style="margin-top: 0.5rem; font-size: 0.875rem; color: #dc2626;">{{ errors.email }}</p>
        </div>

        <!-- Teléfono -->
        <div>
          <label style="display: block; margin-bottom: 0.5rem; font-size: 0.875rem; font-weight: 500; color: #111827;">Teléfono</label>
        <input 
          v-model="formData.phone" 
          type="tel" 
          placeholder="+56 9 1234 5678"
          style="width: 100%; padding: 0.75rem; color: #111827; border: 1px solid #d1d5db; border-radius: 0.5rem; background-color: #f9fafb; font-size: 0.875rem; transition: all 0.2s ease;"
          @blur="onBlur('phone', $event)"
          @focus="(e) => { e.target.style.borderColor = '#3b82f6'; e.target.style.boxShadow = '0 0 0 3px rgba(59, 130, 246, 0.1)'; }"
        />
          <p v-if="errors.phone" style="margin-top: 0.5rem; font-size: 0.875rem; color: #dc2626;">{{ errors.phone }}</p>
        </div>
      </div>

      <!-- Mensaje -->
      <div>
        <label style="display: block; margin-bottom: 0.5rem; font-size: 0.875rem; font-weight: 500; color: #111827;">Cuéntanos sobre tu caso</label>
        <textarea 
          v-model="formData.message" 
          placeholder="Describe brevemente qué necesitas..."
          rows="5"
          style="width: 100%; padding: 0.75rem; color: #111827; border: 1px solid #d1d5db; border-radius: 0.5rem; background-color: #f9fafb; font-size: 0.875rem; resize: none; font-family: inherit; transition: all 0.2s ease;"
          @blur="onBlur('message', $event)"
          @focus="(e) => { e.target.style.borderColor = '#3b82f6'; e.target.style.boxShadow = '0 0 0 3px rgba(59, 130, 246, 0.1)'; }"
        />
        <p v-if="errors.message" style="margin-top: 0.5rem; font-size: 0.875rem; color: #dc2626;">{{ errors.message }}</p>
      </div>

      <!-- Checkbox de Términos -->
      <div style="display: flex; align-items: flex-start; gap: 0.75rem;">
        <input 
          type="checkbox" 
          id="terms" 
          v-model="agreeToTerms"
          style="width: 1rem; height: 1rem; margin-top: 0.25rem; border: 1px solid #d1d5db; border-radius: 0.25rem; background-color: #f9fafb; cursor: pointer; accent-color: #3b82f6;"
        />
        <label for="terms" style="font-size: 0.875rem; font-weight: 500; color: #111827; cursor: pointer;">
          Acepto los <a href="#" style="color: #2563eb; text-decoration: none;">Términos de Servicio</a> y la <a href="#" style="color: #2563eb; text-decoration: none;">Política de Privacidad</a>
        </label>
      </div>

      <!-- Submit Button -->
      <button 
        type="submit" 
        :disabled="isSubmitting || !agreeToTerms"
        :style="{
          width: '100%',
          color: 'white',
          backgroundColor: isSubmitting || !agreeToTerms ? '#9ca3af' : '#1d4ed8',
          fontWeight: '500',
          borderRadius: '0.5rem',
          fontSize: '0.875rem',
          padding: '0.75rem 1.25rem',
          textAlign: 'center',
          transition: 'all 0.2s ease',
          cursor: isSubmitting || !agreeToTerms ? 'not-allowed' : 'pointer',
          border: 'none'
        }"
      >
        {{ isSubmitting ? 'Enviando...' : 'Enviar Consulta' }}
      </button>

      <!-- Messages -->
      <div v-if="successMessage" style="padding: 1rem; font-size: 0.875rem; color: #047857; border-radius: 0.5rem; background-color: #f0fdf4; border: 1px solid #bbf7d0;" role="alert">
        <span style="font-weight: 600;">¡Éxito!</span> {{ successMessage }}
      </div>
      
      <div v-if="errorMessage" style="padding: 1rem; font-size: 0.875rem; color: #dc2626; border-radius: 0.5rem; background-color: #fef2f2; border: 1px solid #fecaca;" role="alert">
        <span style="font-weight: 600;">Error.</span> {{ errorMessage }}
      </div>
    </form>
  </div>
</template>

<script setup>
import { ref, reactive } from 'vue';

const formData = reactive({
  name: '',
  company: '',
  email: '',
  phone: '',
  message: ''
});

const errors = reactive({
  name: '',
  company: '',
  email: '',
  phone: '',
  message: ''
});

const isSubmitting = ref(false);
const successMessage = ref('');
const errorMessage = ref('');
const agreeToTerms = ref(false);

const validateField = (field) => {
  errors[field] = '';
  
  if (!formData[field] || formData[field].trim() === '') {
    errors[field] = 'Este campo es obligatorio';
    return false;
  }
  
  if (field === 'email') {
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!emailRegex.test(formData.email)) {
      errors.email = 'Email inválido';
      return false;
    }
  }
  
  if (field === 'phone') {
    const phoneRegex = /^\+?[0-9\s\-()]{8,}$/;
    if (!phoneRegex.test(formData.phone)) {
      errors.phone = 'Teléfono inválido';
      return false;
    }
  }
  
  return true;
};

const onBlur = (field, event) => {
  validateField(field);
  event.target.style.borderColor = '#d1d5db';
  event.target.style.boxShadow = 'none';
};

const validateForm = () => {
  let isValid = true;
  Object.keys(formData).forEach(field => {
    if (!validateField(field)) {
      isValid = false;
    }
  });
  return isValid;
};

const API_URL = import.meta.env.PUBLIC_API_URL || 'http://localhost:8000';

const handleSubmit = async () => {
  successMessage.value = '';
  errorMessage.value = '';
  
  if (!validateForm()) {
    errorMessage.value = 'Por favor corrige los errores en el formulario';
    return;
  }
  
  isSubmitting.value = true;
  
  try {
    const response = await fetch(`${API_URL}/api/leads`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      },
      body: JSON.stringify({
        name: formData.name,
        email: formData.email,
        phone: formData.phone,
        company: formData.company || null,
        message: formData.message || null,
        source: 'website'
      })
    });

    const data = await response.json();

    if (data.success) {
      successMessage.value = data.message || '¡Gracias por tu interés! Te contactaremos pronto.';
      
      // Google Analytics event (si está configurado)
      if (window.gtag) {
        window.gtag('event', 'form_submit', {
          event_category: 'lead',
          event_label: 'contact_form'
        });
      }
      
      // Limpiar formulario
      Object.keys(formData).forEach(key => {
        formData[key] = '';
      });
      agreeToTerms.value = false;
    } else {
      errorMessage.value = data.message || 'Error al enviar el formulario. Intenta nuevamente.';
    }
  } catch (error) {
    console.error('Form submission error:', error);
    errorMessage.value = 'Error de conexión. Por favor intenta nuevamente o contáctanos directamente.';
  } finally {
    isSubmitting.value = false;
  }
};
</script>
