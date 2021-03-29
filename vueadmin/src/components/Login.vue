<template>
  <div>
    <el-form :rules="rules" :model="loginForm" class="loginContainer" ref="loginForm">
      <h3 class="loginTitle">系统登录</h3>
      <el-form-item prop="username">
        <el-input type="text" v-model="loginForm.username" 
        auto-complete="off" placeholder="请输入用户名" 
        @keydown.enter.native="submitLogin"></el-input>
      </el-form-item>
      <el-form-item prop="password">
        <el-input type="password" v-model="loginForm.password" 
        auto-complete="off" placeholder="请输入密码"
        @keydown.enter.native="submitLogin"></el-input>
      </el-form-item>
      <el-checkbox class="loginRember" v-model="checked">记住我</el-checkbox>
      <el-button type="primary" style="width: 100%" @click="submitLogin">登录</el-button>
    </el-form>
  </div>
</template>
 
<script>
export default {
  name: "Login",
  data(){
    return{
      loginForm:{
        username:"",
        password:""
      },
      checked:true,
      rules:{
        username:[{required:true,message:"用户名不能为空",trigger:"blur"}],
        password:[{required:true,message:"密码不能为空",trigger:"blur"}],
      }
    }
  },
  methods:{
    submitLogin(){//点击登录
      this.$refs.loginForm.validate((validate) =>{  // Element自带的校验
        if(validate){//验证成功 
          this.postKeyValueRequest('/doLogin',this.loginForm).then(res =>{
            //登陆成功
            if(res){
              //在sessionStorage保存登录态 后面会改成使用token
              window.sessionStorage.setItem('user',JSON.stringify(res.obj));
              this.$router.replace('/admin/home');//使用replace可以禁止返回登录页
            }
          })
        }else {//验证非法
          
          return false;
        }
      })
    }
  }

}
</script>
 
<style scoped>
.loginContainer{
  border-radius: 15px;
  background-clip:padding-box;
  margin: 100px auto;
  width: 350px;
  padding: 15px 35px 15px 35px;
  background: #fff;
  border: 1px solid #eaeaea;
  box-shadow: 0 0 25px #cac6c6;
}
.loginTitle{
  margin: 15px auto 20px auto;
  text-align: center;
  color: #505458;
}
.loginRember{
  text-align: left;
  margin: 0 0 25px 0;
}
</style>