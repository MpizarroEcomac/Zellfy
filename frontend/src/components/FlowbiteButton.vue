<template>
  <button
    :class="[
      'px-4 py-2 rounded-lg font-semibold transition-all duration-300',
      variantClasses
    ]"
  >
    <slot />
  </button>
</template>

<script setup>
const props = defineProps({
  variant: {
    type: String,
    default: 'primary',
    validator: (value) => ['primary', 'secondary', 'success', 'danger', 'warning'].includes(value)
  }
});

const variantClasses = {
  primary: 'bg-blue-electric text-white hover:bg-opacity-90 hover:shadow-lg',
  secondary: 'bg-gray-smoke text-gray-800 hover:bg-opacity-80 border border-gray-300',
  success: 'bg-green-mint text-white hover:bg-opacity-90 hover:shadow-lg',
  danger: 'bg-red-500 text-white hover:bg-opacity-90 hover:shadow-lg',
  warning: 'bg-yellow-400 text-gray-800 hover:bg-opacity-90'
}[props.variant];
</script>
