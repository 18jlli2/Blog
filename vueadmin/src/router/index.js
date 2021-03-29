import Vue from 'vue'
import VueRouter from 'vue-router'
import Login from '../components/Login.vue'
import Home from '../views/Home.vue'

Vue.use(VueRouter)

const routes = [
  {
    path:'/',
    redirect:'/admin',
    name:'Login',
    component:Login,
    hidden:true
  },
  {
    path:'/admin',
    name:'Login',
    component:Login,
    hidden:true
  },
  {
    path:'/admin/home',
    name:"Home",
    component:Home
  }

]

const router = new VueRouter({
  mode:'history',
  routes
})

router.beforeEach((to,from,next)=>{
  if(to.path == "/" || to.path == '/admin'){
    next();
  }else{
    if(window.sessionStorage.getItem("user")){
      next()
    }else{
      next('/?redirect=' + to.path);
    }
  }
})

export default router 
