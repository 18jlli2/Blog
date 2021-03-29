import axios from 'axios'
import {Message} from 'element-ui'
import router from '../router'


//响应拦截
axios.interceptors.response.use(success =>{
  if(success.status && success.status == 200 && success.data.status == 500){
    //服务器出错
    Message.error({
      message: success.data.msg
    })
  }
  if(success.data.msg){
    Message.success({
      message: success.data.msg
    })
  }
  return success.data
},error =>{
  if(error.response.status == 504 || error.response.status == 404){//服务器错误
    Message.error({message: "服务器被吃了哦！"})
  }else if(error.response.status == 403){
    Message.error({message: "权限不足，请联系管理员"})
  }else if(error.response.status == 401){
    Message.error({message: "尚未登录"})
    router.replace('/')
  }else{
    //服务器返回的错误信息
    if(error.response.data.msg){
      Message.error({message: error.response.data.msg})
    }else{
      Message.error({message: "未知错误"})
    }
  }
  return;
})

//封装请求
let base = ''; //避免前缀要一个一个去改，太麻烦

export const postKeyValueRequest=(url,params)=>{
  return axios({
    method: 'post',  
    url: `${base}${url}`,
    data: params,
    transformRequest: [function (data){
      let ret = '';
      for(let i in data){
        //往ret上面追加变量 
        ret += encodeURIComponent(i) + '=' + encodeURIComponent(data[i]) + '&'
      }
      return ret;
    }],
    //定义header
    headers:{
      'Content-Type':'application/x-www-form-urlencoded '
    }
  })
}

//封装其他http请求

export const postRequest=(url, params)=>{
  return axios({
      method: 'post',
      url: `${base}${url}`,
      data: params 
  })
}

export const putRequest=(url, params)=>{
  return axios({
      method: 'put',
      url: `${base}${url}`,
      data: params
  })
}

export const getRequest=(url, params)=>{
  return axios({
      method: 'get',
      url: `${base}${url}`,
      data: params
  })
}

export const deleteRequest=(url, params)=>{
  return axios({
      method: 'delete',
      url: `${base}${url}`,
      data: params
  })
}
