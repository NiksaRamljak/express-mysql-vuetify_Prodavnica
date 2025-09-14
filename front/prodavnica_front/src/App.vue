<template>
  <v-app>
    <baseline/>
    <v-main>
      <router-view />
    </v-main>
  </v-app>
</template>

<script setup>

import Baseline from "@/components/baseline.vue"

import { ref, computed, provide } from 'vue';

const token = ref(localStorage.getItem('token') || '');
const isLoggedIn = computed(() => !!token.value);

provide('isLoggedIn', isLoggedIn)
</script>
