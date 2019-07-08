import React, { createContext, useReducer, useContext } from 'react'
import store from './store';
const Context = createContext(null);

export const useStore = () => useContext(Context);

const storeKey = '_react_persist_store';

const persistStore = (state) => {
  if (localStorage[storeKey]) return JSON.parse(localStorage[storeKey])
  return state;
}

export const Provider = props => {
  const [state, dispatch] = useReducer((state, action) => {

    let func = store.actions[action.type];
    let _state = state;
    if (func) _state = func(state, action)

    localStorage[storeKey] = JSON.stringify(_state);
    return _state;
  }, persistStore(store.state));

  return <Context.Provider {...props} value={{ state, dispatch }} />
};

export default Context