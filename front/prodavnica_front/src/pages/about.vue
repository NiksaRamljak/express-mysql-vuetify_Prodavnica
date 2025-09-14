<template>
  <v-responsive>
    <v-row>
      <v-col cols="12">
        <h1>O projektu</h1>
        <p>{{ purpose }}</p>
      </v-col>
    </v-row>

    <v-row>
      <v-col cols="12">
        <h2>Napravljeno sa</h2>
        <v-list>
          <v-list-item v-for="tech in technologies" :key="tech">
            <v-list-item-content>{{ tech }}</v-list-item-content>
          </v-list-item>
        </v-list>
      </v-col>
    </v-row>

    <v-row>
      <v-col cols="12">
        <h2>Autori</h2>
        <v-list>
          <v-list-item v-for="author in authors" :key="author.name">
            <v-list-item-content>
              <v-list-item-title>{{ author.name }}</v-list-item-title>
              <v-list-item-subtitle>{{ author.role }}</v-list-item-subtitle>
            </v-list-item-content>
          </v-list-item>
        </v-list>
      </v-col>
    </v-row>
  </v-responsive>
</template>

<script setup>
import { ref } from 'vue';
import baseline from '@/components/baseline.vue';

const purpose = ref('Ovaj projekt je napravljen kao platforma za e-trgovinu, te pokazuje osnove dinamičnog web dizajna.');

const technologies = ref([
  'JavaScript',
  'Vue.js',
  'Vuetify',
  'Axios',
  'JWT',
  'SQL',
  'NPM'
]);

const authors = ref([
  { name: 'Tonka Čepo', role: 'Frontend Developer' },
  { name: 'Nikša Ramljak', role: 'Backend Developer' },
  { name: 'Nikša Ramljak', role: 'Database Administrator' }
]);
</script>

<style scoped>
h1, h2 {
  margin-bottom: 16px;
}

p {
  margin-bottom: 32px;
}
</style>
