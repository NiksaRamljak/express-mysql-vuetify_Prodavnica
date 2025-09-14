<template>
  <v-container>
    <h1>Your Profile:</h1>
    <v-form @submit.prevent="updateCustomer">
      <v-text-field v-model="customer.UserName" label="Username" disabled></v-text-field>
      <v-text-field v-model="customer.FirstName" label="First Name"></v-text-field>
      <v-text-field v-model="customer.LastName" label="Last Name"></v-text-field>
      <v-text-field v-model="customer.Email" label="Email"></v-text-field>
      <v-btn type="submit">Update</v-btn>
      <v-btn @click="deleteCustomer" color="red">Delete Account</v-btn>
    </v-form>

    <h2>Change Password</h2>
    <v-form @submit.prevent="changePassword">
      <v-text-field v-model="newPassword" label="New Password" type="password"></v-text-field>
      <v-btn type="submit">Change Password</v-btn>
    </v-form>

    <h2>Addresses</h2>
    <v-btn @click="addAddress">Add Address</v-btn>
    <v-list>
      <v-list-item v-for="address in addresses" :key="address.ID">
        <v-list-item-content>
          <v-list-item-title>{{ address.Street }}, {{ address.City }}, {{ address.Zip }}</v-list-item-title>
        </v-list-item-content>
        <v-list-item-action>
          <v-btn @click="editAddress(address)">Edit</v-btn>
          <v-btn @click="deleteAddress(address.ID)">Delete</v-btn>
        </v-list-item-action>
      </v-list-item>
    </v-list>

    <h2>Orders</h2>
    <v-list>
      <v-list-item v-for="order in orders" :key="order.ID">
        <v-list-item-content>
          <v-list-item-title>Order #{{ order.ID }} - {{ order.Date }}</v-list-item-title>
        </v-list-item-content>
        <v-list-item-action>
          <v-btn @click="viewOrder(order.ID)">View</v-btn>
        </v-list-item-action>
      </v-list-item>
    </v-list>

    <h2>Payment Methods</h2>
    <v-btn @click="addPaymentMethod">Add Payment Method</v-btn>
    <v-list>
      <v-list-item v-for="payment in paymentMethods" :key="payment.ID">
        <v-list-item-content>
          <v-list-item-title>{{ payment.Type }} - {{ payment.Details }}</v-list-item-title>
        </v-list-item-content>
        <v-list-item-action>
          <v-btn @click="editPaymentMethod(payment)">Edit</v-btn>
          <v-btn @click="deletePaymentMethod(payment.ID)">Delete</v-btn>
        </v-list-item-action>
      </v-list-item>
    </v-list>
  </v-container>
</template>

<script>
import { ref, onMounted } from 'vue';
import axios from 'axios';

export default {
  name: 'CustomerPage',
  setup() {
    const customer = ref({});
    const addresses = ref([]);
    const orders = ref([]);
    const paymentMethods = ref([]);
    const newPassword = ref('');

    const fetchCustomer = async () => {
      try {
        const response = await axios.get('http://localhost:4390/user/logindata', {
          headers: {Authorization: `Bearer ${localStorage.getItem('token')}`}
        });
        customer.value = response.data;
      } catch (error) {
        console.error('Error fetching customer:', error);
      }
    };

    const updateCustomer = async () => {
      try {
        await axios.put(`http://localhost:4390/customer/${customer.value.ID}`, customer.value, {
          headers: {Authorization: `Bearer ${localStorage.getItem('token')}`}
        });
        alert('Customer updated successfully');
      } catch (error) {
        console.error('Error updating customer:', error);
      }
    };

    const deleteCustomer = async () => {
      try {
        await axios.delete(`http://localhost:4390/user/delete`, {
          headers: {Authorization: `Bearer ${localStorage.getItem('token')}`}
        });
        alert('Customer deleted successfully');
      } catch (error) {
        console.error('Error deleting customer:', error);
      }
    };

    const changePassword = async () => {
      try {
        await axios.patch('http://localhost:4390/user/password', {password: newPassword.value}, {
          headers: {Authorization: `Bearer ${localStorage.getItem('token')}`}
        });
        alert('Password changed successfully');
      } catch (error) {
        console.error('Error changing password:', error);
      }
    };

    const fetchAddresses = async () => {
      try {
        const response = await axios.get('http://localhost:4390/addresses', {
          headers: {Authorization: `Bearer ${localStorage.getItem('token')}`}
        });
        addresses.value = response.data;
      } catch (error) {
        console.error('Error fetching addresses:', error);
      }
    };

    const addAddress = () => {
      // Logic to add a new address
    };

    const editAddress = (address) => {
      // Logic to edit an address
    };

    const deleteAddress = async (id) => {
      try {
        await axios.delete(`http://localhost:4390/addresses/${id}`, {
          headers: {Authorization: `Bearer ${localStorage.getItem('token')}`}
        });
        fetchAddresses();
      } catch (error) {
        console.error('Error deleting address:', error);
      }
    };

    const fetchOrders = async () => {
      try {
        const response = await axios.get('http://localhost:4390/orders', {
          headers: {Authorization: `Bearer ${localStorage.getItem('token')}`}
        });
        orders.value = response.data;
      } catch (error) {
        console.error('Error fetching orders:', error);
      }
    };

    const viewOrder = (id) => {
      // Logic to view an order
    };

    const fetchPaymentMethods = async () => {
      try {
        const response = await axios.get('http://localhost:4390/payment-methods', {
          headers: {Authorization: `Bearer ${localStorage.getItem('token')}`}
        });
        paymentMethods.value = response.data;
      } catch (error) {
        console.error('Error fetching payment methods:', error);
      }
    };

    const addPaymentMethod = () => {
      // Logic to add a new payment method
    };

    const editPaymentMethod = (payment) => {
      // Logic to edit a payment method
    };

    const deletePaymentMethod = async (id) => {
      try {
        await axios.delete(`http://localhost:4390/payment-methods/${id}`, {
          headers: {Authorization: `Bearer ${localStorage.getItem('token')}`}
        });
        fetchPaymentMethods();
      } catch (error) {
        console.error('Error deleting payment method:', error);
      }
    };

    onMounted(() => {
      fetchCustomer();
      fetchAddresses();
      fetchOrders();
      fetchPaymentMethods();
    });

    return {
      customer,
      addresses,
      orders,
      paymentMethods,
      newPassword,
      updateCustomer,
      deleteCustomer,
      changePassword,
      addAddress,
      editAddress,
      deleteAddress,
      viewOrder,
      addPaymentMethod,
      editPaymentMethod,
      deletePaymentMethod
    };
  }
};
</script>

<style scoped>
form {
  display: flex;
  flex-direction: column;
  max-width: 400px;
  margin: auto;
}

div {
  margin-bottom: 10px;
}

label {
  margin-bottom: 5px;
}

input {
  padding: 8px;
  font-size: 16px;
}

button {
  padding: 10px;
  font-size: 16px;
  background-color: #4CAF50;
  color: white;
  border: none;
  cursor: pointer;
}

button:hover {
  background-color: #45a049;
}
</style>
