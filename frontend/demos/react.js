import React from "react";
import ReactDom from "react-dom";
import { Component } from "react";
import { css } from "glamor";

const red = css({
  color: 'red'
});

class HelloWorld extends Component {
  render() {
    return <h1 className={ red }>Hello World from react</h1>;
  }
}

ReactDom.render(<HelloWorld />, document.getElementById("app-container"));
