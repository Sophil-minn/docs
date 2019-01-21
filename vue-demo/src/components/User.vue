<template>
	<div>
		<h2>用户。。。{{fullname}}</h2>
		<div>
			<p>{{$store.state.count}}</p>
			<p></p>
			<p @click="$store.commit('increment')">按钮{{$store.state.count}}</p>
			<p @click="$store.dispatch('commitAdd')">按钮{{$store.state.count}}</p>
			<p @click="$store.dispatch('commitInterval')">按钮{{$store.state.count}}</p>
			
		</div>
	</div>
</template>

<script>
	export default {
		name:'user',
		data() {
			return {
				// fullname:'',
				firstname: 'huang',
				lastname: 'zhengjie'
			}
		},
		props:['logo'],
		created(){
			return {
				
			}
		},

		computed: {
			fullname: {
				get: function(){
					return this.firstname + ' ' + this.lastname;
				},

				set: function(firstname, lastname){
					// this.firstname = firstname;
					// this.lastname = lastname;
				}
			}
		}
	}
</script>

<style>
	
</style>