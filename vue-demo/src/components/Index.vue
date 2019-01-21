<template>
    <div class="index">
        <h1>{{title}}</h1>
        <h2>{{$t("m.AppName")}}</h2>
      
        <router-link :to="'/help'">帮助2</router-link>
        <router-link to="/help">帮助3</router-link>
         <router-link :to="{name:'views'}">单路由多组件</router-link>
        <router-link :to="{name:'paramsname', params:{key1:12, key2:'iloveyou'}}">参数</router-link>

        <!-- <router-link to="/index/user">用户</router-link>
        <router-link to="/index/info">信息(懒)</router-link>
        <router-link to="/index/list/464">列表</router-link> -->

        <router-link v-for="(route, key, index) in routers" :to="route.name" v-bind:key="key">{{route.des}}</router-link>
        <router-view/>
    </div>
</template>

<script>
export default {
    name: 'Index',
    data () {
        return {
           	title : '首页2',
           	routers:[
	           	{
	           		name:'/index/user',
	           		des:'用户',
	           	},{
	           		name:'/index/info',
	           		des:'信息(懒)'
	           	},{
	           		name:'/index/list/464',
	           		des:'列表'
	           	}
           	]
        }
    }
	,beforeRouteEnter (to, from, next) {
	    // 在渲染该组件的对应路由被 confirm 前调用
	    // 不！能！获取组件实例 `this`
	    // 因为当守卫执行前，组件实例还没被创建
	    // console.log(to, from, next)
	    //  此时没有 $router
	    next();
	}
	,beforeRouteUpdate (to, from, next) {
	    // 在当前路由改变，但是该组件被复用时调用
	    // 举例来说，对于一个带有动态参数的路径 /foo/:id，在 /foo/1 和 /foo/2 之间跳转的时候，
	    // 由于会渲染同样的 Foo 组件，因此组件实例会被复用。而这个钩子就会在这个情况下被调用。
	    // 可以访问组件实例 `this`
	    // console.log(to, from, next)
	    console.log("===========beforeRouteUpdate", this.$router)
	    next();
	}
	,beforeRouteLeave (to, from, next) {
	    // 导航离开该组件的对应路由时调用
	    // 可以访问组件实例 `this`
	    // console.log(to, from, next)
	    console.log("--------------beforeRouteLeave", this.$router)
	    next();
	}
	,watch: {
		$route(){
			console.log("watch route...");
		}
	}
	,scrollBehavior(to, from, savedPosition) {
		console.log(to, from, savedPosition);
	}
}
</script>

<style scoped>
	
</style>