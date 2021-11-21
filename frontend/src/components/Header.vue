<template>
  <nav class="navbar navbar-expand-lg navbar-light bg-light px-3">
    <a class="navbar-brand" href="/">GenY</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav">
        <li class="nav-item active">
          <router-link to="/" class="nav-link" >Products</router-link>
        </li>
        <li class="nav-item">
          <!-- <router-link to="/newproduct" class="nav-link" v-if="signedIn()">New Product</router-link> -->
          <router-link to="/newproduct" class="nav-link" v-if="signedIn()">New Product</router-link>
        </li>
        <li class="nav-item">
          <router-link to="/login" class="nav-link" v-if="!signedIn()">Sign in</router-link>
        </li>
        <li class="nav-item">
          <span v-on:click="signOut()" class="nav-link cursor-pointer" v-if="signedIn()">Sign out</span>
        </li>
      </ul>
    </div>
  </nav>
</template>

<script>
  import { getCookie, destroyCookie } from "../tools/cookie-baker";

  export default {
    name: 'Header',
    created () {
      this.signedIn()
    },
    methods: {
      setError (error, text) {
        this.error = (error.response && error.response.data && error.response.data.error) || text
      },
      signedIn () {
        return getCookie("geny-token")
      },
      signOut () {
        destroyCookie("geny-token")
        window.location.href = "http://localhost:8080/";
      }
    }
}
</script>