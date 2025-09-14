<template>
  <v-main>
    <v-container>
      <!-- Hero Section -->
      <v-row class="hero-section" align="center" justify="center">
        <v-col cols="12" md="8">
          <h1 class="text-center">Find the Best Electronic Components</h1>
          <searchProd></searchProd>
        </v-col>
      </v-row>

      <!-- Featured Categories -->
      <v-row>
        <v-col cols="12">
        </v-col>
        <v-col v-for="category in categories" :key="category.id" cols="12" md="4">
          <v-card>
            <v-img :src="category.image" height="200px"></v-img>
            <v-card-title>{{ category.name }}</v-card-title>
          </v-card>
        </v-col>
      </v-row>
    </v-container>
  </v-main>
</template>

<script setup>
import { ref } from 'vue'
import SearchProd from "@/components/searchProd.vue";

</script>

<style>
.title {
  font-weight: bold;
}

.hero-section {
  background: red no-repeat center center;
  background-size: cover;
  height: 300px;
  color: white;
}
</style>
