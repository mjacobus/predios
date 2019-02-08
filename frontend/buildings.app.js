import React from "react";
import ReactDom from "react-dom";
import { BrowserRouter, Route } from "react-router-dom";
import TopMenu from "./src/components/TopMenuContainer";
import { DefaultLayout } from "./library";
import BuildingsIndex from "./src/components/buildings/BuildingsIndexContainer";
import Buildings from "./buildings/pages";
import { combineReducers, createStore, compose, applyMiddleware } from "redux";
import { Provider } from "react-redux";
import thunk from "redux-thunk";
import configReducer from "./src/reducers/configReducer";
import currentUserReducer from "./src/reducers/currentUserReducer";
import buildingsReducer from "./src/reducers/buildingsReducer";
import buildingsListReducer from "./src/reducers/buildingsListReducer";
import buildingViewReducer from "./src/reducers/buildingViewReducer";
import apartmentFormReducer from "./src/reducers/apartmentFormReducer";

const reducers = combineReducers({
  config: configReducer,
  currentUser: currentUserReducer,
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
          <Route exact path="/buildings" component={BuildingsIndex} />
          <Route exact path="/buildings/:number" component={Buildings.Show} />
        </DefaultLayout>
      </div>
    </BrowserRouter>
  </Provider>
);

ReactDom.render(app, document.getElementById("react-app"));
