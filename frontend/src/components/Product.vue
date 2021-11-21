<template>
  <div class="max-w-md m-auto py-2">
    <hr class="border border-grey-light my-6" />

    <ul class="mt-4">
      <div class="py-4">
        <div class="flex items-center justify-between flex-wrap">
          <p class="">
            
          </p>
          <b-container class="bv-example-row">
            <b-row>
              <b-col><span class="text-title">{{ product.title }}</span></b-col>
            </b-row>            
            <b-row>
              <b-col><span class="text-italics">{{ product.summary }}</span></b-col>
            </b-row>
            <b-row>
              <b-col><span class="text-muted text-italics">{{ product.description }}</span></b-col>
            </b-row>
            <b-row>
              <b-col><span>{{ product.final_value }}</span></b-col>
            </b-row>
          </b-container>

          <button class="" @click.prevent="editProduct()" v-if="loginCookie != ''">Edit</button>
          <button class="" @click.prevent="removeProduct()" v-if="loginCookie != ''">Delete</button>
        </div>
      </div>
    </ul>
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
        error: '',
        loginCookie: getCookie('geny-token')
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
      removeProduct () {
        axios.delete(`http://localhost:3000/api/v1/products/${this.$route.params.id}`, {
            headers: {
              'Accept' : 'application/json',
              'content-type': 'application/json',
              'x-csrf-token': getCookie("geny-token")
          }
        })
        .then(response => {
          this.$router.replace(`/`)
        })
        .catch(error => this.setError(error, 'Cannot retrieve product'))
      },
      editProduct () {
        this.$router.replace(`/editproduct/${this.$route.params.id}`)
      }
    }
  }
</script>