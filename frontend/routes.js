import React from "react";
import { BrowserRouter, Route } from "react-router-dom";
import TopMenu from "./library/TopMenuContainer";
import Buildings from "./buildings/pages";
import Apartments from "./apartments/pages";
import { DefaultLayout } from "./library";

export default function Routes() {
  return (
    <BrowserRouter>
      <div>
        <TopMenu />
        <DefaultLayout>
          <Route exact path="/buildings" component={Buildings.List} />
          <Route exact path="/buildings/:number" component={Buildings.Show} />
          <Route
            exact
            path="/buildings/:number/apartments"
            component={Apartments.List}
          />
        </DefaultLayout>
      </div>
    </BrowserRouter>
  );
}
