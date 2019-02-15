import React from "react";
import { connect } from "react-redux";
import { Grid, Col, Row } from "react-bootstrap";
import { css } from "glamor";
import { Loader } from "../../library";
import actions from "../actions";

function mapStateToProps(state) {
  return {};
}

function mapDispatchToProps(dispatch) {
  return {};
}

function ListContainer() {
  return <h1>Apartments</h1>;
}

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(ListContainer);
