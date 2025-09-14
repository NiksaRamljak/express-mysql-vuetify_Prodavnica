<template>
  <v-sheet class="pa-4" color="grey-lighten-4">
    <div v-if="isLoggedIn">
      <div>{{ user.UserName }}</div>
      <div>{{ user.FirstName }} {{ user.LastName }}</div>
      <div>{{ user.Email }}</div>
      <v-btn text @click="goToCustomerPage">Profile</v-btn>
    </div>
    <div v-else>
      Guest
    </div>
    <v-btn text @click="isLoggedIn ? logout() : loginDialog=true">
      {{ isLoggedIn ? 'Logout' : 'Login' }}
    </v-btn>
  </v-sheet>
  <v-dialog v-model="loginDialog" max-width="500px">
    <v-card>
      <v-card-title>
        <span class="headline">Login</span>
      </v-card-title>
      <v-card-text>
        <v-form @submit.prevent="login">
          <v-text-field v-model="loginForm.username" label="Username" required></v-text-field>
          <v-text-field v-model="loginForm.password" label="Password" type="password" required></v-text-field>
          <v-alert v-if="errorMessage" type="error">{{ errorMessage }}</v-alert>
          <v-btn type="submit" color="blue darken-1" :loading="loading" text>Login</v-btn>
          <v-btn color="grey" text @click="loginDialog = false">Cancel</v-btn>
        </v-form>
      </v-card-text>
    </v-card>
  </v-dialog>
</template>

<script setup>
import {ref, onMounted, reactive, inject} from 'vue';
import axios from 'axios';

const user = ref({ UserName: '', FirstName:'', LastName:'', Email: '' });
const loginDialog = ref(false);
const loginForm = reactive({ username: '', password: '' });
const token = ref(localStorage.getItem('token') || '');
const errorMessage = ref('');
const loading = ref(false);
function goToCustomerPage() {
  window.location.href = '/customer';
}
const isLoggedIn = inject('isLoggedIn');
const login = async () => {
  loading.value = true;
  errorMessage.value = '';
  try {
    const response = await axios.post('http://localhost:4390/login', {
      username: loginForm.username,
      password: loginForm.password
    });
    token.value = response.data.token;
    localStorage.setItem('token', token.value);
    loginDialog.value = false;
    await checkToken();
  } catch (error) {
    console.error('Error logging in:', error);
    errorMessage.value = 'Invalid username or password';
  } finally {
    loading.value = false;
  }
};

const checkToken = async () => {
  if (token.value) {
    try {
      const response = await axios.get('http://localhost:4390/user/logindata', {
        headers: { Authorization: `Bearer ${token.value}` }
      });
      console.log(response.data);
      if (response.status === 200) {
        user.value=response.data;
        console.log(user.value);
      } else {
        localStorage.removeItem('token');
        token.value = '';
      }
    } catch (error) {
      console.error('Error verifying token:', error);
      localStorage.removeItem('token');
      token.value = '';
    }
  }
};

const logout = () => {
  localStorage.removeItem('token');
  token.value = '';
  user.value = { UserName: '', FirstName:'', LastName:'', Email: '' };
};

onMounted(() => {
  checkToken();
});
</script>

<style scoped>
.v-container {
  margin-top: 50px;
}
</style>
