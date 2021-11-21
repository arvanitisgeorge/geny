<template>
  <b-container class="text-start mt-4">
    <h3 class="text-2xl mb-6 text-grey-darkest">Sign In</h3>
    <form @submit.prevent="signin">
      <div class="text-red" v-if="error">{{ error }}</div>
      <b-form-group class="py-2" id="input-group-1" label="Email:" label-for="input-2">
        <b-form-input id="input-2" v-model="email" placeholder="anakin@starwars.com" required></b-form-input>
      </b-form-group>
      <b-form-group class="py-2" id="input-group-1" label="Password:" label-for="input-2">
        <b-form-input id="input-2" v-model="password" placeholder="thechosenone" required></b-form-input>
      </b-form-group>
      <button type="submit" class="">Sign In</button>
    </form>
  </b-container>
</template>

<script>
  import axios from 'axios'
  import { getCookie, createCookie } from "../tools/cookie-baker";
  export default {
    name: 'Signin',
    data () {
      return {
        email: '',
        password: '',
        error: ''
      }
    },
    created () {
      if (!getCookie("geny-token")) {
        // this.$router.replace('/')
      }
    },
    methods: {
      signin () {
        axios.post('http://localhost:3000/api/v1/login', { email: this.email, password: this.password })
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