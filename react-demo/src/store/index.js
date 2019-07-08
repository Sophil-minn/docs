const MOD_NAME = 'name';


export default {
  state: {
    count: 0
  },

  actions: {
    [MOD_NAME]: (state, action) => {
      return {
        ...state,
        ...action.payload
      }
    }
  }
}