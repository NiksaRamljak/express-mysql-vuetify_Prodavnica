<template>
  <v-responsive>
      <v-sheet>
        <v-row class="text-center">
          <v-col>
            <h2 class="form-title">Create your new account!</h2>
          </v-col>
        </v-row>
        <v-form>
          <v-text-field
            v-model="usr.firstName"
            :counter="50"
            :error-messages="v$.firstName.$errors.map(e => e.$message)"
            label="First Name"
            required
            @blur="v$.firstName.$touch"
            @input="v$.firstName.$touch"
          ></v-text-field>
          <v-text-field
            v-model="usr.lastName"
            :counter="50"
            :error-messages="v$.lastName.$errors.map(e => e.$message)"
            label="Last Name"
            required
            @blur="v$.lastName.$touch"
            @input="v$.lastName.$touch"
          ></v-text-field>
          <v-text-field
            v-model="usr.username"
            :counter="15"
            :error-messages="v$.username.$errors.map(e => e.$message)"
            label="Username"
            required
            @blur="v$.username.$touch"
            @input="v$.username.$touch"
          ></v-text-field>
          <v-text-field
            v-model="usr.email"
            :error-messages="v$.email.$errors.map(e => e.$message)"
            label="E-mail"
            required
            @blur="v$.email.$touch"
            @input="v$.email.$touch"
          ></v-text-field>

          <v-text-field
            v-model="usr.password"
            :error-messages="v$.password.$errors.map(e => e.$message)"
            label="Password"
            :type="showPassword ? 'text' : 'password'"
            required
            @blur="v$.password.$touch"
            @input="v$.password.$touch"
            class="mb-4"
          >
            <template v-slot:append>
              <v-icon
                @click="showPassword = !showPassword"
                class="cursor-pointer"
                size="24"
                style="margin-right: 8px;"
              >
                {{ showPassword ? 'mdi-eye-off' : 'mdi-eye' }}
              </v-icon>
            </template>
          </v-text-field>
          <v-btn
            class="me-4"
            @click="submitForm"
          >submit</v-btn>
          <v-btn @click="clear">
            clear
          </v-btn>
        </v-form>
      <v-fade-transition hide-on-leave>
        <v-alert v-if="dialog" text="Successfully registered!" color="green"/>
      </v-fade-transition>
    </v-sheet>
  </v-responsive>
</template>

<script setup>
import { reactive, ref } from 'vue'
import { useVuelidate } from '@vuelidate/core'
import { email, required } from '@vuelidate/validators'
import axios from 'axios'

const init = {
  username: '',
  password: '',
  firstName: '',
  lastName: '',
  email: ''
}

const usr = reactive({
  ...init,
})

const rules = {
  username: { required },
  password: { required },
  firstName: { required },
  lastName: { required },
  email: { required, email }
}

const v$ = useVuelidate(rules, usr)

function clear () {
  v$.value.$reset()

  for (const [key, value] of Object.entries(init)) {
    usr[key] = value
  }
}

const dialog = ref(false)
const showPassword = ref(false) // password visibility

async function submitForm() {
  v$.value.$validate()
  if (!v$.value.$invalid) {
    try {
      const response = await axios.post('http://localhost:4390/register', {
        firstName: usr.firstName,
        lastName: usr.lastName,
        username: usr.username,
        email: usr.email,
        password: usr.password,
      })

      if (response.status === 201) {
        dialog.value = true
      } else {
        console.error('Registration error:', response.data.message)
        alert('Registration failed: ' + response.data.message)
      }
    } catch (error) {
      console.error('Registration error:', error)
      alert('An error occurred during registration. Please try again.')
    }
  }
}

</script>

<style scoped>

.v-input--is-focused .v-input__control {
  border-color: #1976D2;
}

.form-title {
  font-size: 2.5rem;
  font-weight: bold;
  color: rgb(255, 255, 255);
  margin-bottom: 20px;
}
.v-sheet{
  margin: 10%;
}
.v-text-field{
  margin: 1%;
}
</style>
