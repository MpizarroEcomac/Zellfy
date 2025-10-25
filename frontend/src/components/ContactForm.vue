<template>
  <div class="bg-white p-8 rounded-2xl shadow-xl">
    <form @submit.prevent="handleSubmit" class="space-y-6">
      <div>
        <label class="block text-sm font-semibold mb-2">Nombre completo</label>
        <input 
          v-model="formData.name" 
          type="text" 
          class="w-full px-4 py-3 border rounded-lg focus:outline-none focus:ring-2 focus:ring-violet-500"
          :class="{'border-red-500': errors.name, 'border-gray-300': !errors.name}"
          placeholder="Tu nombre" 
          @blur="validateField('name')"
        />
        <p v-if="errors.name" class="text-red-500 text-sm mt-1">{{ errors.name }}</p>
      </div>
      
      <div>
        <label class="block text-sm font-semibold mb-2">Empresa</label>
        <input 
          v-model="formData.company" 
          type="text" 
          class="w-full px-4 py-3 border rounded-lg focus:outline-none focus:ring-2 focus:ring-violet-500"
          :class="{'border-red-500': errors.company, 'border-gray-300': !errors.company}"
          placeholder="Nombre de tu empresa" 
          @blur="validateField('company')"
        />
        <p v-if="errors.company" class="text-red-500 text-sm mt-1">{{ errors.company }}</p>
      </div>

      <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
        <div>
          <label class="block text-sm font-semibold mb-2">Email</label>
          <input 
            v-model="formData.email" 
            type="email" 
            class="w-full px-4 py-3 border rounded-lg focus:outline-none focus:ring-2 focus:ring-violet-500"
            :class="{'border-red-500': errors.email, 'border-gray-300': !errors.email}"
            placeholder="tu@email.com" 
            @blur="validateField('email')"
          />
          <p v-if="errors.email" class="text-red-500 text-sm mt-1">{{ errors.email }}</p>
        </div>
        <div>
          <label class="block text-sm font-semibold mb-2">Teléfono</label>
          <input 
            v-model="formData.phone" 
            type="tel" 
            class="w-full px-4 py-3 border rounded-lg focus:outline-none focus:ring-2 focus:ring-violet-500"
            :class="{'border-red-500': errors.phone, 'border-gray-300': !errors.phone}"
            placeholder="+56 9 XXXX XXXX" 
            @blur="validateField('phone')"
          />
          <p v-if="errors.phone" class="text-red-500 text-sm mt-1">{{ errors.phone }}</p>
        </div>
      </div>

      <div>
        <label class="block text-sm font-semibold mb-2">Mensaje</label>
        <textarea 
          v-model="formData.message" 
          rows="5" 
          class="w-full px-4 py-3 border rounded-lg focus:outline-none focus:ring-2 focus:ring-violet-500"
          :class="{'border-red-500': errors.message, 'border-gray-300': !errors.message}"
          placeholder="Cuéntanos sobre tu proyecto..." 
          @blur="validateField('message')"
        ></textarea>
        <p v-if="errors.message" class="text-red-500 text-sm mt-1">{{ errors.message }}</p>
      </div>

      <button 
        type="submit" 
        :disabled="isSubmitting"
        class="w-full px-6 py-4 rounded-full text-white font-bold text-lg transition shadow-lg"
        :class="isSubmitting ? 'opacity-50 cursor-not-allowed' : 'hover:opacity-90'"
        style="background-color: #6C63FF;"
      >
        {{ isSubmitting ? 'Enviando...' : 'Enviar Mensaje' }}
      </button>

      <div v-if="successMessage" class="p-4 bg-green-100 text-green-700 rounded-lg text-center">
        {{ successMessage }}
      </div>
      
      <div v-if="errorMessage" class="p-4 bg-red-100 text-red-700 rounded-lg text-center">
        {{ errorMessage }}
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
