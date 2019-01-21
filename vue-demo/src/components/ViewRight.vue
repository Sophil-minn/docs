<template>
	<div style="display:inline-block;width:50%;float:right;">
		<h2>右参数。。。</h2>
		<h3>{{$route.params.key1}}</h3>
		<p>{{$route.params.key2}}</p>
	</div>
</template>

<script>

export default {
	name:'info',
	data(){
		return {}
	}
}
</script>

<style>
	
</style>