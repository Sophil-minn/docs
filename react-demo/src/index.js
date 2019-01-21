import React from 'react';
import ReactDOM from 'react-dom';
// import './index.css';
// import App from './App';
import { createStore } from 'redux'
import { Provider } from 'react-redux'
import dataReducer from './reducers/dataState.js'
import App from './containers/App.js'
import registerServiceWorker from './registerServiceWorker';

const store = createStore(dataReducer);

ReactDOM.render(
	<IntlProvider locale='zh' messages={zhCN}>
	<Provider store={store}>
		<App/>
	</Provider>
	</IntlProvider>, 
	document.getElementById('root')
);
registerServiceWorker();
