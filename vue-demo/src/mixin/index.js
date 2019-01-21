import Vue from 'vue';


// Vuex Playing Module NameSpace
/* =================================================================
 * 这里提供两个全局的方法，不管感觉这里是挖坑了o(╯□╰)o，不应该这样提供全局方法的
 * ================================================================= */

// Gloabal Mixins
Vue.mixin({
	methods: {
		// // resolve the transition state before route switch
		// goforward(route) {
		// 	store.commit('transition/setTransition', 'turn-on');
		// 	return route;
		// },
		// backward() {
		// 	store.commit('transition/setTransition', 'turn-off')
		// },
		// GLobal Music Play Method
		playMusic(songlist, index, songid) {
		},
		goSpecial(url) {
		}
	}
});