import React from "react";
import ReactDom from "react-dom";
import { BrowserRouter, Route } from "react-router-dom";
import TopMenu from "./library/TopMenuContainer";
import { DefaultLayout } from "./library";
import Buildings from "./buildings/pages";
import { combineReducers, createStore, compose, applyMiddleware } from "redux";
import { Provider } from "react-redux";
import thunk from "redux-thunk";
import {
  buildingsReducer,
  buildingsListReducer,
  apartmentFormReducer,
  buildingViewReducer
} from "./buildings/reducers";

const nullReducer = (state = {}, action) => {
  return state;
};

const reducers = combineReducers({
  config: nullReducer,
  currentUser: nullReducer,
  buildingsList: buildingsListReducer,
  buildingView: buildingViewReducer,
  apartmentForm: apartmentFormReducer,
  entities: combineReducers({
    buildings: buildingsReducer
  })
});

const initialState = {
  config: window.__DATA__.appConfig,
  currentUser: window.__DATA__.currentUser,
  entities: {
    buildings: []
  }
};

// This is necessary for making the the redux store available on the browser's dev tools pannel
const composeEnhancers = window.__REDUX_DEVTOOLS_EXTENSION_COMPOSE__ || compose;
let store = createStore(
  reducers,
  initialState,
  composeEnhancers(applyMiddleware(thunk))
);

const app = (
  <Provider store={store}>
    <BrowserRouter>
      <div>
        <TopMenu />
        <DefaultLayout>
          <Route exact path="/buildings" component={Buildings.List} />
          <Route exact path="/buildings/:number" component={Buildings.Show} />
        </DefaultLayout>
      </div>
    </BrowserRouter>
  </Provider>
);

ReactDom.render(app, document.getElementById("react-app"));
