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

const mockApartment = number => {
  return {
    name: `Nome ${number}`,
    address: `The Address Foo Bar number ${number}`,
    neighborhood: `Bairro ${number}`,
    number: `Bairro ${number}`
  };
};

const mockBuildings = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10].map(i =>
  mockApartment(i)
);

const reducers = combineReducers({
  currentUser: currentUserReducer,
  entities: combineReducers({
    buildings: buildingsReducer
  })
});

const initialState = {
  currentUser: window.__DATA__.currentUser,
  entities: {
    buildings: mockBuildings
  }
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
