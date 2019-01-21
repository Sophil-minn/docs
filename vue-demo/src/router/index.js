import Vue from 'vue'
import VueRouter from 'vue-router'
import Help from '@/components/Help'
import Index from '@/components/Index'
import NotFound from '@/components/404';
import UserF from '@/components/User';
import Params from '@/components/Params';
import Views from '@/components/Views';
import ViewLeft from '@/components/ViewLeft';
import ViewRight from '@/components/ViewRight';

Vue.use(VueRouter)
Vue.use(require('vue-wechat-title'))

const router = new VueRouter({
  mode: 'history',
  scrollBehavior(to,from,savedPosition){
      console.log("savedPosition");
        if(savedPosition){
            return savedPosition;
        }else{
            return {x: 0,y: 0}
        }
    },
  routes: [
    {
      path: '/',
      redirect: '/index',
      meta: {
        title: '首页'
      }
    },
    {
    	path: '/index',
    	name: 'Index',
      meta: {
        title: '首页'
      },
    	component: Index,
      // beforeEnter:(to, from, next)=>{
      //   // console.log(to, from,next)
      //   console.log('router ... beforeEnter...');
      //   next();
      // },
      children: [
        {
          path:'user',
          name:'User',
          component: UserF,
          meta: {
            title: '用刻'
          }
        },
        {
          path:'list/:id',
          meta: {
            title: '列表'
          },
          component:{
            template: `<h3>list参数{{$route.params.id}}</h3>`
          }
        },
        { path: 'info',
          meta: {
            title: '信息'
          }, 
          component: resolve => require(['@/components/Info.vue'], 
            resolve) 
        },
        {
          path: 'params',
          name: 'paramsname',
          component: Params,
          meta: {
            title: '参数'
          }
        }
      ],
      // beforeRouteEnter (to, from, next) {
      //   // 在渲染该组件的对应路由被 confirm 前调用
      //   // 不！能！获取组件实例 `this`
      //   // 因为当守卫执行前，组件实例还没被创建
      //   console.log(to, from, next)
      // },
      // beforeRouteUpdate (to, from, next) {
      //   // 在当前路由改变，但是该组件被复用时调用
      //   // 举例来说，对于一个带有动态参数的路径 /foo/:id，在 /foo/1 和 /foo/2 之间跳转的时候，
      //   // 由于会渲染同样的 Foo 组件，因此组件实例会被复用。而这个钩子就会在这个情况下被调用。
      //   // 可以访问组件实例 `this`
      //   console.log(to, from, next)
      // },
      // beforeRouteLeave (to, from, next) {
      //   // 导航离开该组件的对应路由时调用
      //   // 可以访问组件实例 `this`
      //   console.log(to, from, next)
      // }
    },{
      path: '/help',
      name: 'Help',
      component: Help,
      meta: { requiresAuth: true }
    },{
      path: '/views',
      name: 'views',
      component: Views,
      meta: {
          requireAuth: true,  // 添加该字段，表示进入这个路由是需要登录的
      },
      children:[
        {
          path:'multi',
          components:{
            default: null,
            left: ViewLeft,
            right: ViewRight
          }
        }
      ]
      
    },{
      path: '*',
      name: '404',
      component: NotFound
    }
  ]
});

// 全局路由 钩子函数 - 所有的路由执行前都会执行
router.beforeEach((to, from, next) => {
    if (to.meta.requireAuth) {  // 判断该路由是否需要登录权限
        if (store.state.token) {  // 通过vuex state获取当前的token是否存在
            next();
        }
        else {
            next({
                path: '/login',
                query: {redirect: to.fullPath}  // 将跳转的路由path作为参数，登录成功后跳转到该路由
            })
        }
    }
    else {
        console.log('next()');
        next();

    }
})

export default router;


