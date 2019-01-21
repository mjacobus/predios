import React from "react";
import ReactDom from "react-dom";
import { BrowserRouter, Route } from "react-router-dom";
import TopMenu from "./src/components/TopMenuContainer";
import BuildingsIndex from "./src/components/buildings/BuildingsIndexContainer";
import { Grid, Col, Row } from "react-bootstrap";
import { combineReducers, createStore, compose, applyMiddleware } from "redux";
import { Provider } from "react-redux";
import thunk from 'redux-thunk';
import currentUserReducer from "./src/reducers/currentUserReducer";

const reducers = combineReducers({
  currentUser: currentUserReducer,
});

// This is necessary for making the the redux store available on the browser's dev tools pannel
const composeEnhancers = window.__REDUX_DEVTOOLS_EXTENSION_COMPOSE__ || compose;
let store = createStore(
  reducers,
  undefined,
  composeEnhancers(applyMiddleware(thunk))
);

const Apartments = () => <h1>Apartments</h1>;

const MidContent = props => {
  return (
    <Grid>
      <Row>
        <Col mdOffset={2} sm={12} md={8}>
          {props.children}
        </Col>
      </Row>
    </Grid>
  );
  {
    props.children;
  }
};

const app = (
  <Provider store={store}>
    <BrowserRouter>
      <div>
        <TopMenu />
        <MidContent>
          <Route exact path="/app/buildings" component={BuildingsIndex} />
          <Route
            exact
            path="/app/buildings/:number/apartments"
            component={Apartments}
          />
        </MidContent>
      </div>
    </BrowserRouter>
  </Provider>
);

ReactDom.render(app, document.getElementById("react-app"));
