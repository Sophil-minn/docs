import Vue from 'vue'
import Vuex from 'vuex'

import moduleA from '@/vuex/modules/moduleA'

Vue.use(Vuex)

const store = {
	// 全局
	state: {
		//  访问 this.$store.state.count
        count: 1000
    },
    // 类似 computed
    getters:{
    	count(state) {
    		return state.count;
    	}
    },
    mutations: {
    	// 访问 this.$store.commit('increment', payload)
        increment (state) {
            state.count++
        }
    },
    actions: {

    	commitIncrement ({commit}) {
    		commit('increment');
    	},

    	commitAdd ( context ) {
    		context.commit('increment');
    	},

    	commitInterval (context) {
    		setTimeout(function(){
    			context.commit('increment');
    		},5000)
    	}
    },
    modules: {
    	a:moduleA
    }
}


// import {mapState,mapMutations,mapGetters,mapActions } from 'vuex'
export default new Vuex.Store(
    store
);