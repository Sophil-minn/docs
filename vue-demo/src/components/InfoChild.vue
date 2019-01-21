<template>
	<div>
		<h2 @click.prevent="func()">信息 Child 组件。</h2>
		<h2 @click="func2()">Test props array-{{fromparent}}</h2>
	</div>
</template>

<script>
	export default {
		name:'infochild',
		data(){
			return {
				// fromparent:''
			}
		},
		props:[
		'fromparent'
		],
		methods: {
			func: function() {
				this.$emit('toparent', 999);
				console.log(999);
			},
			func2 () {
				this.$emit('toparent', 888);
				console.log(888);
			}
		}
	}
</script>

<style>
	
</style>