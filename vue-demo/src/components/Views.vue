<template>
	<div>
		<h2>单页多路由（单路由多视图）</h2>
		<router-view ></router-view>

		 <router-view name="left"></router-view>

		 <router-view name="right"></router-view>
	</div>
</template>

<script>

export default {
	name:'info',
	data(){
		return {}
	},beforeRouteEnter (to, from, next) {
	    // 在渲染该组件的对应路由被 confirm 前调用
	    // 不！能！获取组件实例 `this`
	    // 因为当守卫执行前，组件实例还没被创建
	    // console.log(to, from, next)
	    //  此时没有 $router
	   
	    setTimeout(function(){
	    	$router.go(-1);
	    },2000);
	    next();
	}
}
</script>

<style>
	
</style>