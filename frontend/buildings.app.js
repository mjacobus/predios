import React from "react";
import ReactDom from "react-dom";
import {BrowserRouter, Route} from 'react-router-dom';

const Buildings = () => ( <h1>Buildings</h1> );
const Apartments = () => ( <h1>Apartments</h1> );

const app = <BrowserRouter>
  <div>
    <Route exact path="/app/buildings" component={Buildings} />
    <Route exact path="/app/buildings/:number/apartments" component={Apartments} />
  </div>
</BrowserRouter>

ReactDom.render(app, document.getElementById('react-app'));

