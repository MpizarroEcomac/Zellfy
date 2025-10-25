<template>
  <div 
    ref="stepRef"
    class="flex gap-6 items-start transition-all duration-700"
    :class="isVisible ? 'opacity-100 translate-y-0' : 'opacity-0 translate-y-10'"
  >
    <div 
      class="flex-shrink-0 w-16 h-16 rounded-full flex items-center justify-center text-white text-2xl font-bold transition-transform duration-500"
      :class="isVisible ? 'scale-100' : 'scale-50'"
      :style="{ backgroundColor: color }"
    >
      {{ number }}
    </div>
    <div>
      <h3 class="text-2xl font-bold mb-2" :style="{ color }">{{ title }}</h3>
      <p class="text-gray-600">{{ description }}</p>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted, onUnmounted } from 'vue';

const props = defineProps({
  number: {
    type: Number,
    required: true
  },
  title: {
    type: String,
    required: true
  },
  description: {
    type: String,
    required: true
  },
  color: {
    type: String,
    required: true
  }
});

const stepRef = ref(null);
const isVisible = ref(false);

let observer;

onMounted(() => {
  observer = new IntersectionObserver(
    (entries) => {
      entries.forEach((entry) => {
        if (entry.isIntersecting) {
          isVisible.value = true;
        }
      });
    },
    {
      threshold: 0.2
    }
  );

  if (stepRef.value) {
    observer.observe(stepRef.value);
  }
});

onUnmounted(() => {
  if (observer && stepRef.value) {
    observer.unobserve(stepRef.value);
  }
});
</script>
