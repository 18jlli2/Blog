<template>
  <div>
    <el-container>
      <el-header class="homeHeader">
        <a href="/#/admin/home"><div class="title">GitHub万星博客站后台</div></a>
        <el-dropdown class="userInfo" @command="commandHandler">  
          <span class="el-dropdown-link">
            {{user.name}}
            <i><img :src="user.avatar" alt=""></i><!--头像-->
          </span>
          <el-dropdown-menu slot="dropdown">
            <el-dropdown-item command="userInfo">个人中心</el-dropdown-item>
            <el-dropdown-item command="setting">设置</el-dropdown-item>  
            <el-dropdown-item command="logout" divided>注销登录</el-dropdown-item>
          </el-dropdown-menu>
        </el-dropdown>
      </el-header>
      <el-container>
        <el-aside width="200px">
          <el-menu  router>
            <el-menu-item index="/admin/home">
              <i class="el-icon-menu"></i>
              <span slot="title">首页</span>
            </el-menu-item>
            <el-submenu :index="item.path" v-for="(item,index) in this.$router.options.routes" v-if="!item.hidden" :key="index">   
              <!--展示可达组件及其子组件-->
              <template slot="title">
                <i class="el-icon-location"></i>
                <span>{{item.name}}</span>
              </template>
              <el-menu-item :index="child.path" v-for="(child,indexj) in item.children" v-if="!child.hidden" :key="indexj">
                {{child.name}}
              </el-menu-item>                        
            </el-submenu>
          </el-menu>
        </el-aside>
        <el-main>
          <el-breadcrumb separator-class="el-icon-arrow-right" v-if="this.$router.currentRoute.path!='/admin/home'">
            <el-breadcrumb-item :to="{ path: '/admin/home' }">首页</el-breadcrumb-item>
            <el-breadcrumb-item>{{this.$router.currentRoute.name}}</el-breadcrumb-item>
          </el-breadcrumb>
          <div class="homeWelcome" v-if="this.$router.currentRoute.path=='/admin/home'">
            欢迎来到GitHub万星博客站
          </div>
          <router-view/><!--不同栏目的导航-->
        </el-main>
      </el-container>
    </el-container>
  </div>
</template>
 
<script>
export default {
  name: "Home",
  data(){
    return{
      user:JSON.parse(window.sessionStorage.getItem("user"))
    }
  },
  methods:{
    commandHandler(cmd){
      if(cmd=='logout'){
        this.$confirm('真的要走了吗？我需要一个管理员', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(() => {//点击确定后
          this.getRequest("/logout");//发送get请求，退出登录
          window.sessionStorage.removeItem("user")
          this.$router.replace("/")
        }).catch(() => {//点击取消后
          this.$message({
            type: 'info',
            message: '已取消注销'
          });          
        });
      }
    }
  }
}
</script>
 
<style>
  .homeHeader{
    background-color:rgb(0,127,255);
    display: flex;
    align-items: center; /*竖轴上居中*/
    justify-content:space-between; /*flex布局的两侧分布*/
    padding: 0 15px;
    box-sizing: border-box;
  }
  .title{/*标题*/
    font-size: 30px;
    font-family: 华文行楷;
    color: #ffffff;
  }
  .userInfo{
    cursor: pointer; 
  }
  .el-dropdown-link{
    display: flex;
    align-items: center;/*居中*/
  }
  .el-dropdown-link img{/* 头像样式 */
    width: 48px;
    height: 48px;
    border-radius: 24px;
    margin-left: 8px;
  }
  .homeWelcome{
    text-align: center;
    font-size: 30px;
    font-family: 华文行楷;
    color: #409eff;
    padding-top: 50px;
  }
  a{
    text-decoration:none;
  }
</style>