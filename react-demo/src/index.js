import React from 'react';
import ReactDOM from 'react-dom';
import { HashRouter as Router, Route, Switch } from "react-router-dom";
// HashRouter, BrowserRouter
import './index.css';

import routes from './router';
import { Provider } from './context.js'

import * as serviceWorker from './serviceWorker';


Object.prototype[Symbol.iterator] = function () {
  let index = 0;
  let propKeys = Reflect.ownKeys(this);
  let obj = this;
  return {
    next() {
      if (index < propKeys.length) {
        let key = propKeys[index];
        index++;
        return { value: [key, obj[key]] };
      } else {
        return { done: true };
      }
    }
  }
}


const Root = () => {
  return (
    <Provider>
      <Router>
        <Switch>
          {routes.map(({ path, title, component }, index) => (
            <Route
              key={index}
              exact
              path={path}
              component={component}
            />
          ))}
        </Switch>
      </Router>
    </Provider>
  )
}


ReactDOM.render(<Root />, document.getElementById('root'));

// If you want your app to work offline and load faster, you can change
// unregister() to register() below. Note this comes with some pitfalls.
// Learn more about service workers: https://bit.ly/CRA-PWA
serviceWorker.unregister();
