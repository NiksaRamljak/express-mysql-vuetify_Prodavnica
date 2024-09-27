<template>
  <v-responsive>
  <v-navigation-drawer v-model="drawer" app>
    <login/>
    <v-divider></v-divider>
    <v-list>
      <v-list-item v-for="text in links"
                   :key="text"
                   :title="text.text"
                   :href="text.link">
      </v-list-item>
    </v-list>
  </v-navigation-drawer>
  <v-app-bar app>
    <v-app-bar-nav-icon @click="drawer = !drawer"></v-app-bar-nav-icon>
    <v-app-bar-title>Rakun</v-app-bar-title>
  </v-app-bar>
  </v-responsive>
</template>

<script setup>
import { ref } from 'vue';
import login from './login.vue';
const links =[
  {text:'Home',link:'/'},
  {text:'Register',link:'register'},
  {text:'Categories',link:'categories'},
  {text:'About',link:'about'},
  ]
const drawer = ref(null);
</script>

<style scoped>
.v-app-bar-title{
  text-align: center;
}
@media (max-width: 600px) {
  .v-navigation-drawer{
    width: 100% !important;
  }
}
</style>
