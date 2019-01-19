import React from "react";
import ReactDom from "react-dom";
import { BrowserRouter, Route } from "react-router-dom";
import Navbar from "./src/components/Navbar";
import BuildingsIndex from "./src/components/buildings/BuildingsIndexContainer";

const Apartments = () => <h1>Apartments</h1>;

const app = (
  <BrowserRouter>
    <div>
      <Navbar/>
      <Route exact path="/app/buildings" component={BuildingsIndex} />
      <Route
        exact
        path="/app/buildings/:number/apartments"
        component={Apartments}
      />
    </div>
  </BrowserRouter>
);

ReactDom.render(app, document.getElementById("react-app"));
