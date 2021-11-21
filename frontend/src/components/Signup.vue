<template>
  <b-container class="text-start mt-4">
    <h3 class="text-2xl mb-6 text-grey-darkest">Sign Up</h3>
    <form @submit.prevent="signup">
      <div class="text-red" v-if="error">{{ error }}</div>
      <b-form-group class="py-2" id="input-group-1" label="Name:" label-for="input-1">
        <b-form-input id="input-1" v-model="name" placeholder="Anakin" required></b-form-input>
      </b-form-group>
      <b-form-group class="py-2" id="input-group-2" label="Surname:" label-for="input-2">
        <b-form-input id="input-2" v-model="surname" placeholder="Skywalker" required></b-form-input>
      </b-form-group>
      <b-form-group class="py-2" id="input-group-3" label="Email:" label-for="input-3">
        <b-form-input id="input-3" v-model="email" placeholder="anakin@starwars.com" required></b-form-input>
      </b-form-group>
      <b-form-group class="py-2" id="input-group-4" label="Password:" label-for="input-4">
        <b-form-input id="input-4" v-model="password" placeholder="thechosenone" required></b-form-input>
      </b-form-group>
      <button type="submit" class="">Sign Up</button>
    </form>
  </b-container>
</template>

<script>
  import axios from 'axios'
  import { getCookie, createCookie } from "../tools/cookie-baker";
  export default {
    name: 'Signup',
    data () {
      return {
        name: '',
        surname: '',
        email: '',
        password: '',
        error: ''
      }
    },
    created () {
      if (getCookie("geny-token")) {
        this.$router.replace('/')
      }
    },
    methods: {
      signup () {
        axios.post('http://localhost:3000/api/v1/signup', { name: this.name, surname: this.surname, email: this.email, password: this.password })
          .then(response => this.signinSuccessful(response))
          .catch(error => this.signinFailed(error))
      },
      signinSuccessful (response) {
        if (!response.data.csrf) {
          this.signinFailed(response)
          return
        }
        createCookie('geny-token', response.data.csrf, 30)
        this.error = ''
        this.$router.replace('/')
        window.location.href = "http://localhost:8080/";
      },
      signinFailed (error) {
        this.error = (error.response && error.response.data && error.response.data.error) || ''
      }
    }
  }
</script>