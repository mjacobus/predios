import React from "react";
import ReactDom from "react-dom";
import { combineReducers, createStore, compose, applyMiddleware } from "redux";
import { Provider } from "react-redux";
import thunk from "redux-thunk";
import buildings from "./buildings/reducers";
import apartments from "./apartments/reducers";
import users from "./users/reducers";
import contactAttempts from "./contact-attempts/reducers";
import Routes from "./routes";

const nullReducer = (state = {}, action) => {
  return state;
};

const reducers = combineReducers({
  config: nullReducer,
  currentUser: nullReducer,
  usersList: users.usersListReducer,
  buildingsList: buildings.buildingsListReducer,
  buildingView: buildings.buildingViewReducer,
  newBuilding: buildings.newBuildingReducer,
  editBuilding: buildings.editBuildingReducer,
  apartmentForm: buildings.apartmentFormReducer,
  apartmentsList: apartments.apartmentsListReducer,
  removeApartment: apartments.removeApartmentReducer,
  newContactAttempt: contactAttempts.newContactAttemptReducer,
  entities: combineReducers({
    buildings: buildings.buildingsReducer
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
    <Routes />
  </Provider>
);

ReactDom.render(app, document.getElementById("react-app"));
