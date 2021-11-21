import Vue from 'vue'
import Router from 'vue-router'
import Main from '@/components/Main'
import NewProduct from '@/components/NewProduct'
import Login from '@/components/Login'
import Product from '@/components/Product'
import EditProduct from '@/components/EditProduct'
import Signup from '@/components/Signup'

Vue.use(Router)

export default new Router({
  mode: 'history',
  routes: [
    {
      path: '/',
      name: 'Main',
      component: Main
    },
    {
      path: '/newproduct',
      component: NewProduct
    },
    {
      path: '/login',
      component: Login
    },
    {
      path: '/signup',
      component: Signup
    },
    { 
      path: '/product/:id', 
      component: Product 
    },
    { 
      path: '/editproduct/:id', 
      component: EditProduct 
    },
  ]
})
