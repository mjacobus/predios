import React from "react";
import ReactDom from "react-dom";
import { BrowserRouter, Route } from "react-router-dom";
import TopMenu from "./src/components/library/TopMenu";
import BuildingsIndex from "./src/components/buildings/BuildingsIndexContainer";
import { Grid, Col, Row } from "react-bootstrap";

const Apartments = () => <h1>Apartments</h1>;

const MidContent = (props) => {
  return <Grid>
    <Row>
      <Col mdOffset={2} sm={12} md={8}>{ props.children }</Col>
    </Row>
  </Grid>
  { props.children }
};

const app = (
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
);

ReactDom.render(app, document.getElementById("react-app"));
