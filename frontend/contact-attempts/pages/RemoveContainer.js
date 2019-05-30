import React from "react";
// import { Redirect } from "react-router-dom";
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

  submitValues(values) {
    // TODO: Sumit for real
    console.log("submiting", values.remove);
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
    createContactAttempt: actions.createContactAttempt(dispatch),
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
