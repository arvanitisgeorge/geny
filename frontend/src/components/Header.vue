<template>
  <nav class="navbar navbar-expand-lg navbar-light bg-light px-3">
    <a class="navbar-brand" href="/">GenY</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav">
        <li class="nav-item active">
          <router-link to="/" class="nav-link" v-if="!signedIn()">Products</router-link>
        </li>
        <li class="nav-item">
          <!-- <router-link to="/newproduct" class="nav-link" v-if="signedIn()">New Product</router-link> -->
          <router-link to="/newproduct" class="nav-link" v-if="!signedIn()">New Product</router-link>
        </li>
        <li class="nav-item">
          <router-link to="/login" class="nav-link" v-if="!signedIn()">Sign in</router-link>
        </li>
      </ul>
    </div>
  </nav>
</template>

<script>
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
      console.log(1)
      return localStorage.signedIn
    },
    signOut () {
      this.$http.secured.delete('/signin')
        .then(response => {
          delete localStorage.csrf
          delete localStorage.signedIn
          this.$router.replace('/')
        })
        .catch(error => this.setError(error, 'Cannot sign out'))
    }
  }
}
</script>