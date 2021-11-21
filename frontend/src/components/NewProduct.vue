<template>
  <b-container class="text-start">
    <h3 class="font-mono font-regular text-3xl mt-3 mb-2">New product</h3>
    <b-form @submit="addProduct" @reset="onReset">
      <b-form-group class="py-2" id="input-group-1" label="Title:" label-for="input-1">
        <b-form-input
          id="input-1"
          v-model="newProduct.title"
          placeholder="Enter title"
          required
        ></b-form-input>
      </b-form-group>

      <b-form-group class="py-2" id="input-group-2" label="Summary:" label-for="input-2">
        <b-form-input id="input-2" v-model="newProduct.summary" placeholder="Enter summary" required></b-form-input>
      </b-form-group>

      <b-form-group class="py-2" id="input-group-3" label="Description:" label-for="input-3">
        <b-form-input id="input-3" v-model="newProduct.description" placeholder="Enter description" required></b-form-input>
      </b-form-group>

      <b-form-group class="py-2" id="input-group-4" label="Value:" label-for="input-4">
        <b-form-input id="input-4" v-model="newProduct.final_value" placeholder="Enter Value" required></b-form-input>
      </b-form-group>

      <b-button type="submit" variant="primary">Submit</b-button>
      <b-button type="reset" variant="danger">Reset</b-button>
    </b-form>
  </b-container>
</template>

<script>
  import axios from 'axios'
  import { createCookie, getCookie } from "../tools/cookie-baker";
  
  // Todo place this to the login page
  createCookie("geny-token", "Zezx2CUnCI2Jrgt1sdZ4tlfPKPdylCClJBOqY+KcC2M94bh8B/2s+ZO00vme6Ktf7LU9cpq7afU8Yw4g3zX4zw==", 20)

  export default {
    name: 'NewProduct',
    data () {
      return {
        newProduct: [],
        error: '',
      }
    },
    created () {
      if (getCookie("geny-token") == "") {
        this.$router.replace('/')
      }
    },
    methods: {
      setError (error, text) {
        this.error = (error.response && error.response.data && error.response.data.error) || text
      },
      addProduct (event) {
        event.preventDefault()
        const product = this.newProduct

        console.log(product)
        if (!product) {
          return
        }

        axios.defaults.headers.common['X-CSRF-TOKEN'] = getCookie("geny-token");
        axios.post('http://localhost:3000/api/v1/products', { 
          product: 
            { 
              title: this.newProduct.title, 
              summary: this.newProduct.summary, 
              description: this.newProduct.description, 
              final_value: this.newProduct.final_value, 
              initial_value: this.newProduct.final_value 
            }
          },
          {
            headers: {
              'Accept' : 'application/json',
              'content-type': 'application/json',
              'x-csrf-token': getCookie("geny-token")
            }
          }
        )
        .then(response => {
          this.$router.replace(`/product/${response.id}`)
        })
        .catch(error => this.setError(error, 'Cannot retrieve products'))
      },
      onReset () {
        this.$router.replace('/')
      }
    }
  }
</script>
