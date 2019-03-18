import React from "react";
import { BrowserRouter, Route } from "react-router-dom";
import TopMenu from "./library/TopMenuContainer";
import EnvironmentBanner from "./library/EnvironmentBanner";
import Buildings from "./buildings/pages";
import Apartments from "./apartments/pages";
import Users from "./users/pages";
import ContactAttempts from "./contact-attempts/pages";
import { DefaultLayout } from "./library";

export default function Routes() {
  return (
    <BrowserRouter>
      <div>
        <TopMenu />
        <EnvironmentBanner />
        <DefaultLayout>
          <Route exact path="/users" component={Users.List} />
          <Route exact path="/buildings" component={Buildings.List} />
          <Route exact path="/buildings/new" component={Buildings.New} />
          <Route
            exact
            path="/buildings/:buildingNumber/edit"
            component={Buildings.Edit}
          />
          <Route
            exact
            path="/buildings/:buildingNumber/apartments"
            component={Apartments.List}
          />
          <Route
            exact
            path="/buildings/:buildingNumber/apartments/:apartmentNumber/contact-attempts/new"
            component={ContactAttempts.New}
          />
        </DefaultLayout>
      </div>
    </BrowserRouter>
  );
}
