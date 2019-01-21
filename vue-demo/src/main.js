// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import App from './App'
import router from './router'
import './filters'
import './mixin'
// for store
import store from '@/vuex/store'
// fore axios
import axios from 'axios'
// fore i18n
import VueI18n from 'vue-i18n'
// for lazyload
import VueLazyLoad from 'vue-lazyload'

Vue.use(VueLazyLoad,{
    preLoad: 1.3,
    error:'./assets/error.png',
    loading:'./assets/loading.png',
    attempt: 1,
    listenEvents: ['scroll', 'mousewheel']
});

Vue.prototype.$http = axios;

Vue.config.productionTip = false



Vue.use(VueI18n)
const i18n = new VueI18n({
    // locale: 'zh-CN',
    locale:'en-US',
    // 语言切换
    //this.$i18n.locale 
    /*
	changeLanguage(){//语言切换
       if(this.$i18n.locale =='zh-CN'){
           this.$i18n.locale = 'en-US'
       }else{
           this.$i18n.locale = 'zh-CN'
       }
    }
    */
    // 语言字符串使用
    // {{$t("m.welcome")}}
    messages: {
        'zh-CN': require('./assets/js/lang/zh'),
        'en-US': require('./assets/js/lang/en')
    }
})

/* eslint-disable no-new */
new Vue({
  el: '#app',
  router, // 使用 route
  store, // 使用 store
  i18n,
  template: '<App/>',
  components: { App }
})
