<template>
  <v-container>
    <v-row>
      <v-col cols="12" md="6">
        <v-text-field
          v-model="search"
          label="Search Products"
          append-icon="mdi-magnify"
          single-line
          hide-details
        ></v-text-field>
      </v-col>
      <v-col cols="12" md="6">
        <v-select
          v-model="selectedCategory"
          :items="categories"
          item-title="Name"
          item-value="ID"
          label="Select Category"
          single-line
          hide-details
        ></v-select>
      </v-col>
    </v-row>
    <v-row>
      <v-col v-for="product in filteredProducts" :key="product.ID" cols="auto" sm="6" md="4">
        <v-card>
          <v-img :src="product.ProductThumbnail" height="200px"></v-img>
          <v-card-title>{{ product.ProductName }}</v-card-title>
          <v-card-subtitle>{{ product.ProductPrice + " €" }}</v-card-subtitle>
          <v-card-text>{{ product.ProductDescription }}</v-card-text>
          <v-card-text>{{ product.ProductManufacturer }}</v-card-text>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import { ref, computed } from 'vue';
import axios from 'axios';

export default {
  data() {
    return {
      search: '',
      categories: [],
      products: [],
      selectedCategory: null,
    };
  },
  computed: {
    filteredProducts() {
      console.log(this.products);
      return this.products.filter(product => {
        const matchesSearch = product.ProductName.toLowerCase().includes(this.search.toLowerCase()) ||
          product.ProductDescription.toLowerCase().includes(this.search.toLowerCase()) ||
          product.ProductManufacturer.toLowerCase().includes(this.search.toLowerCase());
        const matchesCategory = this.selectedCategory ? product.Categories.includes(this.selectedCategory): true;
        return matchesSearch && matchesCategory;
      });
    },
  },
  methods: {
    fetchCategories() {
      axios.get('http://localhost:4390/search/categories')
        .then(response => {
          this.categories = response.data;
        })
        .catch(error => {
          console.error('Error fetching categories:', error);
        });
    },
    fetchProducts() {
      axios.get(`http://localhost:4390/search/products`)
        .then(response => {
          this.products = response.data;
        })
        .catch(error => {
          console.error('Error fetching products:', error);
        });
    },
  },
  created() {
    this.fetchCategories();
    this.fetchProducts();
  },
};
</script>
