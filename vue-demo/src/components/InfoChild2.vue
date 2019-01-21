<template>
	<div>
		<h2>Test props Object。-{{fromparent}}</h2>
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
		props:{
			fromparent:{
				// type: String
			}
		},
		methods: {
		}
	}
</script>

<style>
	
</style>