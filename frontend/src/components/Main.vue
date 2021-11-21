<template>
  <div class="max-w-md m-auto py-2">
    <ul class="mt-4">
      <div class="py-4" v-for="product in products" :key="product.id">
        <div class="flex items-center justify-between flex-wrap">
          <b-container v-on:click="$router.replace(`/product/${product.id}`)" class="bv-example-row cursor-pointer">
            <b-row>
              <b-col><span class="text-title">{{ product.title }}</span></b-col>
            </b-row>            
            <b-row>
              <b-col><span class="text-italics">{{ product.summary }}</span></b-col>
            </b-row>
          </b-container>
        </div>
      </div>
    </ul>
  </div>
</template>

<script>
  import axios from 'axios'

  export default {
    name: 'Main',
    data () {
      return {
        products: [],
        error: '',
        editedProduct: ''
      }
    },
    mounted () {
      axios.get('http://localhost:3000/api/v1/products')
      .then(response => {
        this.products = response.data
      })
      .catch(error => this.setError(error, 'Cannot retrieve products'))
    },
    methods: {
      setError (error, text) {
        this.error = (error.response && error.response.data && error.response.data.error) || text
      },
    }
  }
</script>