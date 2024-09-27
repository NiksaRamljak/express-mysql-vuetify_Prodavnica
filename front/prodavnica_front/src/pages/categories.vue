<template>
  <v-responsive>
    <v-container>
      <h1 class="title">Component categories:</h1>
      <v-row>
      <v-col v-for="category in categories" :key="category.ID" cols="auto" sm="6" md="4">
        <v-card @click="selectCategory(category.ID)">
          <v-img :src="category.Thumb" height="200px"></v-img>
          <v-card-title>{{ category.Name }}</v-card-title>
        </v-card>
      </v-col>
      </v-row>
    </v-container>
    <v-spacer></v-spacer>
    <div ref="componentSection">
      <v-row>
      <v-col v-for="component in paginatedComponents" :key="component.ID" cols="auto" sm="6" md="4">
        <v-card @click="selectComponent(component)">
          <v-card-item>
            <v-img :src="component.ProductThumbnail"></v-img>
          </v-card-item>
          <v-card-title>{{ component.ProductName }}</v-card-title>
          <v-card-subtitle>{{ component.ProductPrice+" €" }}</v-card-subtitle>
        </v-card>
      </v-col>
      </v-row>
      <v-pagination v-model="page" :length="totalPages"/>
    </div>
    <v-dialog v-model="dialog" max-width="600px">
      <v-card>
        <v-card-title>{{ selectedComponent.ProductName }}</v-card-title>
        <v-card-text>
          <p>{{ selectedComponent.ProductDescription }}</p>
          <p>Price: {{ selectedComponent.ProductPrice }}</p>
          <p>Stock: {{ selectedComponent.ProductStock }}</p>
          <p>Manufacturer: {{ selectedComponent.ProductManufacturer }}</p>
          <p>Categories: {{ selectedComponent.Categories }}</p>
        </v-card-text>
        <v-card-actions>
          <v-btn color="primary" @click="addToOrder" v-if="isLoggedIn">Add to Order</v-btn>
          <v-btn color="secondary" @click="dialog = false">Close</v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
  </v-responsive>
</template>

<script>
import axios from 'axios';
import {inject} from 'vue';
export default {
  data() {
    return {
      categories: [],
      components: [],
      selectedCategory: null,
      selectedComponent: {},
      dialog: false,
      page: 1,
      isLoggedIn: inject('isLoggedIn'), // Assume you have a way to check if the user is logged in
    };
  },
  computed: {
    paginatedComponents() {
      const start = (this.page - 1) * 4;
      const end = start + 4;
      return this.components.slice(start, end);
    },
    totalPages() {
      return Math.ceil(this.components.length / 4);
    },
  },
  methods: {
    fetchCategories() {
      axios.get('http://localhost:4390/categories')
        .then(response => {
          this.categories = response.data;
        })
        .catch(error => {
          console.error('Error fetching categories:', error);
        });
    },
    selectCategory(categoryID) {
      this.selectedCategory = categoryID;
      this.fetchComponents(categoryID);
      this.$refs.componentSection.scrollIntoView({ behavior: 'smooth' });
    },
    fetchComponents(categoryID) {
      axios.get(`http://localhost:4390/categories/${categoryID}`)
        .then(response => {
          this.components = response.data;
        })
        .catch(error => {
          console.error('Error fetching components:', error);
        });
    },
    selectComponent(component) {
      this.selectedComponent = component;
      this.dialog = true;
    },
    addToOrder() {
      // Implement the logic to add the product to an order
      console.log('Add to order:', this.selectedComponent);
    },
  },
  created() {
    this.fetchCategories();
  },
};
</script>
<style scoped>
h1.title {
  text-align: center;
}
</style>
