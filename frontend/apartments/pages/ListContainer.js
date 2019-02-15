import React from "react";
import { connect } from "react-redux";
import { Grid, Col, Row } from "react-bootstrap";
import { css } from "glamor";
import { Loader } from "../../library";
import actions from "../actions";
import { ApartmentForm, BuildingHeader } from "../../shared/components";
import { Apartments } from "../components";

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

class ListContainer extends React.Component {
  componentDidMount() {
    if (this.props.apartments == null) {
      this.fetchApartments();
    }
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
      <div>
        <BuildingHeader building={this.props.building} />
        <ApartmentForm building={this.props.building} />
        <Apartments
          apartments={this.props.apartments}
          building={this.props.building}
        />
      </div>
    );
  }
}

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(ListContainer);
