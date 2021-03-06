import React from "react";
import { connect } from "react-redux";
import { Grid, Col, Row } from "react-bootstrap";
import { css } from "glamor";
import { Loader } from "../../library";
import actions from "../actions";
import {
  ApartmentForm,
  BuildingHeader,
  PageBlock
} from "../../shared/components";
import Apartments from "./list/Apartments";

class ListContainer extends React.Component {
  componentDidMount() {
    this.fetchApartments();
  }

  fetchApartments() {
    const { buildingNumber } = this.props.match.params;
    this.props.fetchApartments({ buildingNumber });
  }

  render() {
    if (this.props.fetching) {
      return <Loader />;
    }

    return (
      <>
        <ApartmentForm building={this.props.building} />
        <BuildingHeader building={this.props.building} />
        <Apartments
          apartments={this.props.apartments}
          building={this.props.building}
        />
      </>
    );
  }
}

function mapStateToProps(state) {
  return {
    building: state.apartmentsList.building,
    apartments: state.apartmentsList.apartments,
    fetching: state.apartmentsList.fetching
  };
}

function mapDispatchToProps(dispatch) {
  return {
    fetchApartments: actions.fetchApartments(dispatch)
  };
}

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(ListContainer);
