<template>
  <span>{{ displayValue }}</span>
</template>

<script setup lang="ts">
import { ref, watch, onUnmounted } from 'vue'

const props = withDefaults(defineProps<{
  value: number
  duration?: number
}>(), { duration: 800 })

const displayValue = ref(0)
let rafId: number | null = null

function animate(from: number, to: number) {
  if (rafId) cancelAnimationFrame(rafId)
  if (from === to) { displayValue.value = to; return }
  const start = performance.now()

  function tick(now: number) {
    const progress = Math.min((now - start) / props.duration, 1)
    // easeOutExpo
    const eased = progress === 1 ? 1 : 1 - Math.pow(2, -10 * progress)
    displayValue.value = Math.round(from + (to - from) * eased)
    if (progress < 1) rafId = requestAnimationFrame(tick)
  }

  rafId = requestAnimationFrame(tick)
}

watch(() => props.value, (to, from) => animate(from ?? 0, to), { immediate: true })
onUnmounted(() => { if (rafId) cancelAnimationFrame(rafId) })
</script>