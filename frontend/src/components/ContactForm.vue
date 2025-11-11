<template>
  <div class="w-full">
    <form @submit.prevent="handleSubmit" class="space-y-6">
        <!-- Nombre completo -->
        <div>
          <label class="block text-sm font-semibold text-slate-700 mb-3">Nombre completo</label>
          <input 
            v-model="formData.name" 
            type="text" 
            class="w-full px-4 py-3 border-2 rounded-lg bg-white focus:outline-none transition-all font-medium text-slate-900"
            :class="{'border-red-500 focus:border-red-500': errors.name, 'border-slate-200 focus:border-blue-500 focus:ring-2 focus:ring-blue-200': !errors.name}"
            placeholder="Tu nombre completo" 
            @blur="validateField('name')"
          />
          <p v-if="errors.name" class="text-red-600 text-sm mt-2 font-medium">{{ errors.name }}</p>
        </div>
        
        <!-- Empresa -->
        <div>
          <label class="block text-sm font-semibold text-slate-700 mb-3">Empresa</label>
          <input 
            v-model="formData.company" 
            type="text" 
            class="w-full px-4 py-3 border-2 rounded-lg bg-white focus:outline-none transition-all font-medium text-slate-900"
            :class="{'border-red-500 focus:border-red-500': errors.company, 'border-slate-200 focus:border-blue-500 focus:ring-2 focus:ring-blue-200': !errors.company}"
            placeholder="Nombre de tu empresa" 
            @blur="validateField('company')"
          />
          <p v-if="errors.company" class="text-red-600 text-sm mt-2 font-medium">{{ errors.company }}</p>
        </div>

        <!-- Email y Teléfono -->
        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
          <div>
            <label class="block text-sm font-semibold text-slate-700 mb-3">Email</label>
            <input 
              v-model="formData.email" 
              type="email" 
              class="w-full px-4 py-3 border-2 rounded-lg bg-white focus:outline-none transition-all font-medium text-slate-900"
              :class="{'border-red-500 focus:border-red-500': errors.email, 'border-slate-200 focus:border-blue-500 focus:ring-2 focus:ring-blue-200': !errors.email}"
              placeholder="tu@email.com" 
              @blur="validateField('email')"
            />
            <p v-if="errors.email" class="text-red-600 text-sm mt-2 font-medium">{{ errors.email }}</p>
          </div>
          <div>
            <label class="block text-sm font-semibold text-slate-700 mb-3">Teléfono</label>
            <input 
              v-model="formData.phone" 
              type="tel" 
              class="w-full px-4 py-3 border-2 rounded-lg bg-white focus:outline-none transition-all font-medium text-slate-900"
              :class="{'border-red-500 focus:border-red-500': errors.phone, 'border-slate-200 focus:border-blue-500 focus:ring-2 focus:ring-blue-200': !errors.phone}"
              placeholder="+56 9 XXXX XXXX" 
              @blur="validateField('phone')"
            />
            <p v-if="errors.phone" class="text-red-600 text-sm mt-2 font-medium">{{ errors.phone }}</p>
          </div>
        </div>

        <!-- Mensaje -->
        <div>
          <label class="block text-sm font-semibold text-slate-700 mb-3">Mensaje</label>
          <textarea 
            v-model="formData.message" 
            rows="5" 
            class="w-full px-4 py-3 border-2 rounded-lg bg-white focus:outline-none transition-all font-medium text-slate-900 resize-none"
            :class="{'border-red-500 focus:border-red-500': errors.message, 'border-slate-200 focus:border-blue-500 focus:ring-2 focus:ring-blue-200': !errors.message}"
            placeholder="Cuéntanos sobre tu proyecto, necesidades y objetivos..." 
            @blur="validateField('message')"
          ></textarea>
          <p v-if="errors.message" class="text-red-600 text-sm mt-2 font-medium">{{ errors.message }}</p>
        </div>

        <!-- Botón Enviar -->
        <button 
          type="submit" 
          :disabled="isSubmitting"
          class="w-full px-6 py-4 rounded-lg text-white font-bold text-lg transition-all duration-300 mt-8"
          :class="isSubmitting ? 'opacity-60 cursor-not-allowed bg-slate-400' : 'bg-gradient-to-r from-blue-600 to-cyan-500 hover:from-blue-700 hover:to-cyan-600 hover:shadow-lg hover:shadow-blue-500/30 transform hover:-translate-y-0.5'"
        >
          <span v-if="isSubmitting" class="flex items-center justify-center">
            <svg class="animate-spin h-5 w-5 mr-3" viewBox="0 0 24 24">
              <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4" fill="none"></circle>
              <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
            </svg>
            Enviando...
          </span>
          <span v-else>Enviar Mensaje</span>
        </button>

        <!-- Mensajes de éxito y error -->
        <div v-if="successMessage" class="p-4 bg-gradient-to-r from-green-50 to-emerald-50 border-2 border-green-500 text-green-700 rounded-lg text-center font-semibold">
          ✓ {{ successMessage }}
        </div>
        
        <div v-if="errorMessage" class="p-4 bg-gradient-to-r from-red-50 to-pink-50 border-2 border-red-500 text-red-700 rounded-lg text-center font-semibold">
          ✕ {{ errorMessage }}
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

const validateForm = () => {
  let isValid = true;
  Object.keys(formData).forEach(field => {
    if (!validateField(field)) {
      isValid = false;
    }
  });
  return isValid;
};

const handleSubmit = async () => {
  successMessage.value = '';
  errorMessage.value = '';
  
  if (!validateForm()) {
    errorMessage.value = 'Por favor corrige los errores en el formulario';
    return;
  }
  
  isSubmitting.value = true;
  
  try {
    // TODO: Conectar con API Laravel cuando esté disponible
    // const response = await fetch('/api/contact', {
    //   method: 'POST',
    //   headers: { 'Content-Type': 'application/json' },
    //   body: JSON.stringify(formData)
    // });
    
    // Simulación de envío exitoso
    await new Promise(resolve => setTimeout(resolve, 1500));
    
    successMessage.value = '¡Mensaje enviado! Te contactaremos pronto.';
    
    // Limpiar formulario
    Object.keys(formData).forEach(key => {
      formData[key] = '';
    });
  } catch (error) {
    errorMessage.value = 'Error al enviar el mensaje. Intenta nuevamente.';
  } finally {
    isSubmitting.value = false;
  }
};
</script>
