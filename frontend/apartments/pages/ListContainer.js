import React from "react";
import { connect } from "react-redux";
import { Grid, Col, Row } from "react-bootstrap";
import { css } from "glamor";
import { Loader } from "../../library";
import actions from "../actions";
import Apartment from "../../buildings/pages/show/Apartment";

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
    return (
      <div>
        {this.props.apartments &&
          this.props.apartments.map(a => (
            <Apartment
              apartment={a}
              key={a.uuid}
              bellClick={() => bellClick(a)}
            />
          ))}
      </div>
    );
  }
}

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(ListContainer);
