import React from "react";
import ReactDom from "react-dom";
import { Component } from "react";

class HelloWorld extends Component {
  render() {
    return <h1>Hello World from react</h1>;
  }
}

ReactDom.render(<HelloWorld />, document.getElementById("app-container"));
