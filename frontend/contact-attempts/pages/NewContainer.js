import React from "react";
import { Redirect } from "react-router-dom";
import { Loader } from "../../library";
import { connect } from "react-redux";
import {
  createContactAttempt,
  attemptContactOn
} from "../../buildings/actions";
import { BuildingHeader } from "../../shared/components";
import Form from "./new/Form";
import actions from "../actions";
import { clearRedirect } from "../../shared/actions";

function mapStateToProps(state) {
  return {
    fetching: state.newContactAttempt.fetching,
    building: state.newContactAttempt.building,
    apartment: state.newContactAttempt.apartment,
    creating: state.newContactAttempt.creating,
    redirectTo: state.newContactAttempt.redirectTo
  };
}

function mapDispatchToProps(dispatch) {
  return {
    createContactAttempt: createContactAttempt(dispatch),
    attemptContactOn: attemptContactOn(dispatch),
    fetchApartmentByBuildingNumber: actions.fetchApartmentByBuildingNumber(
      dispatch
    ),
    clearRedirect: clearRedirect(dispatch)
  };
}

class NewContactAttemptForm extends React.Component {
  constructor(props) {
    super(props);
    this.handleCreateContactAttempt = this.handleCreateContactAttempt.bind(
      this
    );
    this.cancelContactAttempt = this.cancelContactAttempt.bind(this);
  }

  componentDidMount() {
    if (this.props.apartment == null) {
      const { buildingNumber, apartmentNumber } = this.props.match.params;
      this.props.fetchApartmentByBuildingNumber({
        buildingNumber,
        apartmentNumber
      });
    }
  }

  componentWillUnmount() {
    this.props.clearRedirect();
  }

  handleCreateContactAttempt(apartment, outcome) {
    const { building } = this.props;
    let payload = {
      building,
      apartment,
      outcome
    };
    this.props.createContactAttempt(payload);
  }

  cancelContactAttempt() {
    this.props.attemptContactOn(null);
  }

  render() {
    const props = this.props;

    if (props.redirectTo) {
      return <Redirect to={props.redirectTo} />;
    }

    if (props.fetching) {
      return <Loader />;
    }

    const { apartment, building } = props;

    return (
      <Form
        apartment={apartment}
        building={building}
        assignAttempt={this.handleCreateContactAttempt}
      />
    );
  }
}

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(NewContactAttemptForm);
