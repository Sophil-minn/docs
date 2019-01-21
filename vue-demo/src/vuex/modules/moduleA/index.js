export default {
	state: {
		testA: 1,
		testB: 5
	},

	getters: {
		testA (context) {
			return context.testA + context.testB;
		}
	},

	mutations: {
		incrementA(context){
			context.testB++;
		}
	},

	actions: {

	}
}