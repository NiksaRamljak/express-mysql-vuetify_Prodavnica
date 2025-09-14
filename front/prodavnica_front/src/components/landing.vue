<!--
<template>
  <v-app id="inspire">
    <v-system-bar>
      <v-spacer></v-spacer>

      <v-icon>mdi-square</v-icon>

      <v-icon>mdi-circle</v-icon>

      <v-icon>mdi-triangle</v-icon>
    </v-system-bar>

    <v-app-bar
      color="grey-lighten-4"
      height="72"
      flat
    >
      <v-avatar
        class="ms-2"
        color="surface-variant"
        size="32"
        variant="flat"
      ></v-avatar>
      <v-avatar
        class="mx-2"
        color="surface-variant"
        size="32"
        variant="flat"
      ></v-avatar>

      <v-btn
        class="me-2"
        color="grey"
        height="40"
        variant="flat"
        width="80"
      ></v-btn>

      <v-btn
        class="me-2"
        color="grey"
        height="40"
        variant="flat"
        width="100"
      ></v-btn>

      <v-btn
        class="me-2"
        color="grey"
        height="40"
        variant="flat"
        width="120"
      ></v-btn>

      <v-btn
        class="me-2"
        color="grey"
        height="40"
        variant="flat"
        width="120"
      ></v-btn>

      <v-spacer></v-spacer>
    </v-app-bar>

    <v-footer
      color="grey"
      height="44"
      app
    ></v-footer>

    <v-navigation-drawer floating>
      <div class="d-flex px-2 my-2">
        <v-btn
          class="flex-grow-1"
          color="grey"
          height="40"
          variant="flat"
        ></v-btn>

        <v-avatar
          class="ms-2"
          color="surface-variant"
          variant="flat"
          rounded
        ></v-avatar>
      </div>

      <div class="d-flex px-2 my-2 align-center">
        <v-btn
          class="flex-grow-1 me-2"
          color="grey-lighten-4"
          height="40"
          variant="flat"
        ></v-btn>

        <v-avatar
          color="surface-variant"
          size="18"
        ></v-avatar>

        <v-avatar
          class="ms-1"
          color="surface-variant"
          size="18"
        ></v-avatar>
      </div>

      <div class="px-2 my-2">
        <v-text-field
          class="mb-4"
          density="compact"
          prepend-inner-icon="mdi-magnify"
          variant="solo-filled"
          flat
          hide-details
        ></v-text-field>

        <v-sheet
          class="mb-2"
          color="surface-variant"
          height="24"
          rounded="pill"
          width="50%"
        ></v-sheet>

        <v-sheet
          class="mb-1"
          color="grey-lighten-1"
          height="12"
          rounded="pill"
          width="40%"
        ></v-sheet>

        <v-sheet
          class="mb-1"
          color="grey-lighten-1"
          height="12"
          rounded="pill"
          width="20%"
        ></v-sheet>

        <v-sheet
          class="mb-1"
          color="grey-lighten-1"
          height="12"
          rounded="pill"
          width="90%"
        ></v-sheet>

        <v-sheet
          color="grey-lighten-1"
          height="12"
          rounded="pill"
          width="70%"
        ></v-sheet>

        <v-divider class="my-6"></v-divider>

        <v-sheet
          class="mb-2"
          color="surface-variant"
          height="24"
          rounded="pill"
          width="30%"
        ></v-sheet>

        <v-sheet
          class="mb-1"
          color="grey-lighten-1"
          height="12"
          rounded="pill"
          width="65%"
        ></v-sheet>

        <v-sheet
          class="mb-1"
          color="grey-lighten-1"
          height="12"
          rounded="pill"
          width="70%"
        ></v-sheet>

        <v-sheet
          class="mb-1"
          color="grey-lighten-1"
          height="12"
          rounded="pill"
          width="40%"
        ></v-sheet>

        <v-sheet
          color="grey-lighten-1"
          height="12"
          rounded="pill"
          width="100%"
        ></v-sheet>

        <v-divider class="my-6"></v-divider>
      </div>
    </v-navigation-drawer>

    <v-main>
      <v-sheet
        class="mx-auto pa-2 pt-6"
        color="grey-lighten-4"
      >
        <v-sheet
          color="grey-lighten-2"
          height="24"
          rounded="pill"
          width="88"
        ></v-sheet>

        <v-slide-group show-arrows>
          <v-slide-group-item
            v-for="n in 5"
            :key="n"
          >
            <v-sheet
              class="ma-3"
              color="grey-lighten-1"
              height="200"
              width="250"
              rounded
            ></v-sheet>
          </v-slide-group-item>
        </v-slide-group>
      </v-sheet>

      <v-sheet
        class="mx-auto pa-2 pt-6"
        color="grey-lighten-2"
      >
        <v-sheet
          color="grey"
          height="24"
          rounded="pill"
          width="88"
        ></v-sheet>

        <v-slide-group show-arrows>
          <v-slide-group-item
            v-for="n in 15"
            :key="n"
          >
            <v-sheet
              :width="n === 1 ? 300 : 150"
              class="ma-3"
              color="grey-lighten-1"
              height="200"
              rounded
            ></v-sheet>
          </v-slide-group-item>
        </v-slide-group>

        <v-container fluid>
          <v-row>
            <v-col
              v-for="n in 24"
              :key="n"
              cols="2"
            >
              <v-sheet
                color="grey-lighten-1"
                height="200"
                rounded
              ></v-sheet>
            </v-col>
          </v-row>
        </v-container>
      </v-sheet>
    </v-main>
  </v-app>

        <template v-slot:default="{ isActive }">
          <v-card title="Dialog">
            <v-card-text>
              Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
            </v-card-text>

            <v-card-actions>
              <v-spacer></v-spacer>
              <v-btn text="Close Dialog" @click="isActive.value = false"></v-btn>
            </v-card-actions>
          </v-card>
        </template>
      </v-dialog>
    </v-main>


</template>
-->

<template>
  <v-container fluid class="no-border">
    <!-- Hero Section -->
    <v-sheet class="hero-section" color="primary" height="400">
      <v-row align="center" justify="center" class="text-center">
        <v-col cols="12">
          <h1 class="display-1 white--text">Welcome to Our Project</h1>
          <v-btn color="secondary" large>Learn More</v-btn>
        </v-col>
      </v-row>
    </v-sheet>

    <!-- Technologies Section -->
    <v-container class="my-5">
      <h2 class="text-center">Technologies Used</h2>
      <v-row>
        <v-col v-for="tech in technologies" :key="tech" cols="12" md="4">
          <v-card>
            <v-card-title>{{ tech }}</v-card-title>
          </v-card>
        </v-col>
      </v-row>
    </v-container>

    <!-- Authors Section -->
    <v-container class="my-5">
      <h2 class="text-center">Authors</h2>
      <v-row>
        <v-col v-for="author in authors" :key="author" cols="12" md="4">
          <v-card>
            <v-card-title>{{ author }}</v-card-title>
          </v-card>
        </v-col>
      </v-row>
    </v-container>

    <!-- Footer -->
    <v-footer color="grey darken-3" class="white--text text-center py-3">
      <v-container>
            <p>&copy; 2024 Our Project. All rights reserved.</p>
            <v-btn icon>
              <v-icon>mdi-facebook</v-icon>
            </v-btn>
            <v-btn icon>
              <v-icon>mdi-twitter</v-icon>
            </v-btn>
            <v-btn icon>
              <v-icon>mdi-instagram</v-icon>
            </v-btn>
      </v-container>
    </v-footer>
  </v-container>
</template>

<script setup>
import { ref } from 'vue';

const technologies = ref([
  'SQL',
  'JavaScript',
  'NPM',
  'Vue'
]);

const authors = ref([
  'Author 1',
  'Author 2',
  'Author 3'
]);
</script>

<style scoped>
.hero-section {
  background: url("http://localhost:4390/img/Bitcoin.png") center center / cover no-repeat;
}
.no-border {
  padding: 0%;
}
</style>
