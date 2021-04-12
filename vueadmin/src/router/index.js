import Vue from 'vue'
import VueRouter from 'vue-router'
import Login from '../components/Login.vue'
import Home from '../views/Home.vue'
import AllCon from '../views/BlogControl/AllCon.vue'
import CategoryCon from '../views/BlogControl/CategoryCon.vue'
import CommentCon from '../views/BlogControl/CommentCon.vue'
import LinksCon from '../views/BlogControl/LinksCon.vue'
import TagCon from '../views/BlogControl/TagCon.vue'
import WriteCon from '../views/BlogControl/WriteCon.vue'
import EditCon from '../views/BlogControl/EditCon.vue'

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
    name:"博客管理",
    component:Home,
    children:[
      {path:'/admin/home/AllCon',name:"文章管理",component:AllCon},
      {path:'/admin/EditCon/:id',name:'编辑博客',component:EditCon,props:true,hidden:true},
      {path:'/admin/home/WriteCon',name:"撰写博客",component:WriteCon},
      {path:'/admin/home/CategoryCon',name:"分类管理",component:CategoryCon},
      {path:'/admin/home/CommentCon',name:"评论管理",component:CommentCon},
      {path:'/admin/home/TagCon',name:"标签管理",component:TagCon},
      {path:'/admin/home/LinksCon',name:"友链管理",component:LinksCon},
    ],
    meta:{
      isLogin:true
    }
  }

]

const router = new VueRouter({
  routes
})

router.beforeEach((to,from,next)=>{
  let auth = window.sessionStorage.getItem("user");
  if(to.path == "/admin" && auth){
    next({
      path:"/admin/home"
    })
  }else if(to.matched.some(res=>res.meta.isLogin)){//判断是否需要登录
    if(auth){//有授权了 
      next();
    }else{//无授权

      next({
        path:"/admin",
        query:{
          redirect:to.fullPath
        }
      })
    }
  }else{
    next()
  }
})

export default router   
