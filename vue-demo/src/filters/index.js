import Vue from 'vue';


// 全局过滤器
Vue.filter( 'discount' , function(value,discount) {
  return value  * ( discount / 100 ) ;
});