import React from "react";
import { connect } from "react-redux";
import { Grid, Col, Row } from "react-bootstrap";
import { css } from "glamor";
import { Loader } from "../../library";
import actions from "../actions";

function mapStateToProps(state) {
  return {
    apartments: state.apartmentsList.apartments
  };
}

function mapDispatchToProps(dispatch) {
  return {
    fetchApartments: actions.fetchApartments(dispatch)
  };
}

class ListContainer extends React.Component {
  componentDidMout() {
    const buildingNumber = "1";
    this.props.fetchApartments({ buildingNumber });
  }
  render() {
    return <h1>Apartments</h1>;
  }
}

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(ListContainer);
