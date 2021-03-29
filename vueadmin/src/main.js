import Vue from 'vue'
import App from './App.vue'
import router from './router'
import ElementUI from 'element-ui'; 
import 'element-ui/lib/theme-chalk/index.css';

import {postKeyValueRequest,
  postRequest,putRequest,getRequest,deleteRequest} from "./utils/api";


Vue.prototype.postKeyValueRequest = postKeyValueRequest;
Vue.prototype.postRequest = postRequest;
Vue.prototype.putRequest = putRequest;
Vue.prototype.getRequest = getRequest;
Vue.prototype.deleteRequest = deleteRequest;

Vue.use(ElementUI); //使用 ElementUI

Vue.config.productionTip = false



new Vue({
  router,
  render: h => h(App)
}).$mount('#app')
