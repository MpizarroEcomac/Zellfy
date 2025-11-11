<template>
  <div class="w-full max-w-md mx-auto">
    <div class="bg-gradient-to-b from-blue-100/60 to-purple-100/40 rounded-3xl p-8 backdrop-blur-sm border border-white/40 shadow-2xl">
      <form @submit.prevent="handleSubmit" class="space-y-4">
        <!-- Nombre -->
        <div class="relative">
          <svg class="absolute left-4 top-4 w-5 h-5 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"></path>
          </svg>
          <input 
            v-model="formData.name" 
            type="text" 
            placeholder="First Name"
            class="w-full pl-12 pr-4 py-3 rounded-full bg-white/90 placeholder-gray-400 text-gray-800 focus:outline-none focus:ring-2 focus:ring-purple-400 transition-all"
            @blur="validateField('name')"
          />
          <p v-if="errors.name" class="text-red-600 text-xs mt-1 ml-4">{{ errors.name }}</p>
        </div>

        <!-- Apellido (Empresa) -->
        <div class="relative">
          <svg class="absolute left-4 top-4 w-5 h-5 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 21H5a2 2 0 01-2-2V5a2 2 0 012-2h11l5 5v11a2 2 0 01-2 2z"></path>
          </svg>
          <input 
            v-model="formData.company" 
            type="text" 
            placeholder="Last Name"
            class="w-full pl-12 pr-4 py-3 rounded-full bg-white/90 placeholder-gray-400 text-gray-800 focus:outline-none focus:ring-2 focus:ring-purple-400 transition-all"
            @blur="validateField('company')"
          />
          <p v-if="errors.company" class="text-red-600 text-xs mt-1 ml-4">{{ errors.company }}</p>
        </div>

        <!-- Username/Email -->
        <div class="relative">
          <svg class="absolute left-4 top-4 w-5 h-5 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path>
          </svg>
          <input 
            v-model="formData.email" 
            type="email" 
            placeholder="Email"
            class="w-full pl-12 pr-4 py-3 rounded-full bg-white/90 placeholder-gray-400 text-gray-800 focus:outline-none focus:ring-2 focus:ring-purple-400 transition-all"
            @blur="validateField('email')"
          />
          <p v-if="errors.email" class="text-red-600 text-xs mt-1 ml-4">{{ errors.email }}</p>
        </div>

        <!-- Password (Teléfono) -->
        <div class="relative">
          <svg class="absolute left-4 top-4 w-5 h-5 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z"></path>
          </svg>
          <input 
            v-model="formData.phone" 
            type="tel" 
            placeholder="Password"
            class="w-full pl-12 pr-4 py-3 rounded-full bg-white/90 placeholder-gray-400 text-gray-800 focus:outline-none focus:ring-2 focus:ring-purple-400 transition-all"
            @blur="validateField('phone')"
          />
          <p v-if="errors.phone" class="text-red-600 text-xs mt-1 ml-4">{{ errors.phone }}</p>
        </div>

        <!-- Confirm Password (Mensaje) -->
        <div class="relative">
          <svg class="absolute left-4 top-4 w-5 h-5 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z"></path>
          </svg>
          <input 
            v-model="formData.message" 
            type="text" 
            placeholder="Confirm Password"
            class="w-full pl-12 pr-4 py-3 rounded-full bg-white/90 placeholder-gray-400 text-gray-800 focus:outline-none focus:ring-2 focus:ring-purple-400 transition-all"
            @blur="validateField('message')"
          />
          <p v-if="errors.message" class="text-red-600 text-xs mt-1 ml-4">{{ errors.message }}</p>
        </div>

        <!-- Checkbox -->
        <div class="flex items-center gap-2 px-4 py-2">
          <input type="checkbox" id="terms" class="rounded cursor-pointer" />
          <label for="terms" class="text-sm text-gray-600 cursor-pointer">
            I agree to the Terms of Use and Privacy Policy
          </label>
        </div>

        <!-- Sign Up Button -->
        <button 
          type="submit" 
          :disabled="isSubmitting"
          class="w-full px-6 py-3 rounded-full text-white font-bold text-sm uppercase tracking-wide transition-all duration-300 mt-6"
          :class="isSubmitting ? 'opacity-60 cursor-not-allowed bg-gray-400' : 'bg-gradient-to-r from-purple-600 to-purple-800 hover:from-purple-700 hover:to-purple-900 hover:shadow-lg transform hover:-translate-y-1'"
        >
          {{ isSubmitting ? 'Enviando...' : 'SIGN UP' }}
        </button>

        <!-- Sign In Link -->
        <p class="text-center text-sm text-gray-600 mt-4">
          Already a member? 
          <a href="#" class="text-purple-600 font-semibold hover:underline">Sign In</a>
        </p>

        <!-- Messages -->
        <div v-if="successMessage" class="p-3 bg-green-100 text-green-700 rounded-lg text-center text-sm font-semibold mt-4">
          ✓ {{ successMessage }}
        </div>
        
        <div v-if="errorMessage" class="p-3 bg-red-100 text-red-700 rounded-lg text-center text-sm font-semibold mt-4">
          ✕ {{ errorMessage }}
        </div>
      </form>
    </div>
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
