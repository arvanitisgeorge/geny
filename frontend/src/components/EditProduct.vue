<template>
  <div class="max-w-md m-auto py-2">
      <b-container v-if="product" class="text-start">
        <h3 class="font-mono font-regular text-3xl mt-3 mb-2">Edit product</h3>
        <b-form @submit.prevent="updateProduct()" @reset="onReset">
          <b-form-group class="py-2" id="input-group-1" label="Title:" label-for="input-1">
            <b-form-input
              id="input-1"
              v-model="product.title"
              placeholder="Enter title"
              required
            ></b-form-input>
          </b-form-group>

          <b-form-group class="py-2" id="input-group-2" label="Summary:" label-for="input-2">
            <b-form-input id="input-2" v-model="product.summary" placeholder="Enter summary" required></b-form-input>
          </b-form-group>

          <b-form-group class="py-2" id="input-group-3" label="Description:" label-for="input-3">
            <b-form-input id="input-3" v-model="product.description" placeholder="Enter description" required></b-form-input>
          </b-form-group>

          <b-form-group class="py-2" id="input-group-4" label="Value:" label-for="input-4">
            <b-form-input id="input-4" v-model="product.final_value" placeholder="Enter Value" required></b-form-input>
          </b-form-group>

          <b-button type="submit" variant="primary">Submit</b-button>
          <b-button type="reset" variant="danger">Reset</b-button>
        </b-form>
      </b-container>
  </div>
</template>

<script>
  import axios from 'axios'
  import { getCookie } from "../tools/cookie-baker";

  export default {
    name: 'Main',
    data () {
      return {
        product: [],
        error: ''
      }
    },
    created () {
      if (getCookie("geny-token") == "") {
        this.$router.replace('/')
      }
    },
    mounted () {
      axios.get(`http://localhost:3000/api/v1/products/${this.$route.params.id}`)
      .then(response => {
        this.product = response.data
      })
      .catch(error => this.setError(error, 'Cannot retrieve product'))
    },
    methods: {
      setError (error, text) {
        this.error = (error.response && error.response.data && error.response.data.error) || text
      },
      updateProduct () {
        axios.put(`http://localhost:3000/api/v1/products/${this.$route.params.id}`,
          { 
            title: this.product.title, 
            summary: this.product.summary, 
            description: this.product.description, 
            final_value: this.product.final_value, 
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
          this.$router.replace(`/product/${response.data.id}`)
        })
        .catch(error => this.setError(error, 'Cannot update product'))
      },
      onReset () {
        this.$router.replace(`/product/${this.$route.params.id}`)
      }
    }
  }
</script>