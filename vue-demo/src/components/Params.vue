<template>
	<div>
		<h2>参数。。。</h2>
		<h3>{{$route.params.key1}}</h3>
		<p>{{$route.params.key2}}</p>
		<p>{{$route.path}}</p>
		<p>{{$route.query}}</p>
		<p>{{$route.name}}</p>
<!-- 		<p>{{$route.matched|tostring}}</p>
		<p>{{$route.params|tostring}}</p> -->
		<p>{{{name:'huangzhengjie'}|stringfy}}</p>
	</div>
</template>

<script>

export default {
	name:'info',
	data(){
		return {}
	},
	filters: {
		stringfy: function(val) {
			console.log(val);
			return JSON.stringify(val);
		}
	}
}
</script>

<style>
	
</style>