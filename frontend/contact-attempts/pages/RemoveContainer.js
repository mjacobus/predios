import React from "react";
import { Redirect } from "react-router-dom";
import { Loader } from "../../library";
import { connect } from "react-redux";
import Form from "./remove/Form";
import actions from "../actions";
import { clearRedirect } from "../../shared/actions";

class RemoveContactAttempt extends React.Component {
  constructor(props) {
    super(props);
    this.submitValues = this.submitValues.bind(this);
    this.state = { formData: {} };
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

  submitValues({ contactAttempts }) {
    const { building, apartment } = this.props;
    this.props.handleSubmit({ contactAttempts, building, apartment });
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

    // frontend/contact-attempts/pages/RemoveContainer.js
    return (
      <Form
        currentUser={this.props.currentUser}
        apartment={apartment}
        building={building}
        submitValues={this.submitValues}
        assignAttempt={this.handleCreateContactAttempt}
      />
    );
  }
}

function mapStateToProps(state) {
  return {
    currentUser: state.currentUser,
    fetching: state.removeContactAttempts.fetching,
    building: state.removeContactAttempts.building,
    apartment: state.removeContactAttempts.apartment,
    removing: state.removeContactAttempts.removing,
    redirectTo: state.removeContactAttempts.redirectTo
  };
}

function mapDispatchToProps(dispatch) {
  return {
    handleSubmit: actions.removeContactAttempts(dispatch),
    fetchApartmentByBuildingNumber: actions.fetchApartmentByBuildingNumber(
      dispatch
    ),
    clearRedirect: clearRedirect(dispatch)
  };
}

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(RemoveContactAttempt);
