<template>
	<div>
		<h2>信息。。。</h2>
		<Child fromparent="ssdfsdf" @toparent="getFromChild"></Child>
		<Child2 fromparent="ssdfsdf" @toparent="getFromChild"></Child2>
	</div>
</template>

<script>
import InfoChild from '@/components/InfoChild';
import InfoChild2 from '@/components/InfoChild2';
export default {
	name:'info',
	components:{
		'Child': InfoChild
		,'Child2': InfoChild2
	},
	data(){
		return {}
	},
	methods:{
		getFromChild: function(val){
			console.log("********getFromChild:",val);
		}
	}
}
</script>

<style>
	
</style>