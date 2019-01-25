import React from "react";
import ReactDom from "react-dom";
import { BrowserRouter, Route } from "react-router-dom";
import TopMenu from "./src/components/TopMenuContainer";
import DefaultLayout from "./src/components/library/Layouts.js";
import BuildingsIndex from "./src/components/buildings/BuildingsIndexContainer";
import { combineReducers, createStore, compose, applyMiddleware } from "redux";
import { Provider } from "react-redux";
import thunk from "redux-thunk";
import currentUserReducer from "./src/reducers/currentUserReducer";
import buildingsReducer from "./src/reducers/buildingsReducer";

const reducers = combineReducers({
  currentUser: currentUserReducer,
  entities: {
    buildings: buildingsReducer
  }
});

const initialState = {
  currentUser: window.__DATA__.currentUser
};

// This is necessary for making the the redux store available on the browser's dev tools pannel
const composeEnhancers = window.__REDUX_DEVTOOLS_EXTENSION_COMPOSE__ || compose;
let store = createStore(
  reducers,
  initialState,
  composeEnhancers(applyMiddleware(thunk))
);

const Apartments = () => <h1>Apartments</h1>;

const app = (
  <Provider store={store}>
    <BrowserRouter>
      <div>
        <TopMenu />
        <DefaultLayout>
          <Route exact path="/app/buildings" component={BuildingsIndex} />
          <Route
            exact
            path="/app/buildings/:number/apartments"
            component={Apartments}
          />
        </DefaultLayout>
      </div>
    </BrowserRouter>
  </Provider>
);

ReactDom.render(app, document.getElementById("react-app"));
