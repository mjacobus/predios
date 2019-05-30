import React from "react";
import { Redirect } from "react-router-dom";
import { Loader } from "../../library";
import { connect } from "react-redux";
import Form from "./new/Form";
import actions from "../actions";
import { clearRedirect } from "../../shared/actions";

class NewContactAttemptForm extends React.Component {
  constructor(props) {
    super(props);
    this.handleCreateContactAttempt = this.handleCreateContactAttempt.bind(
      this
    );
    this.inputListenerFactory = this.inputListenerFactory.bind(this);
    this.cancelContactAttempt = this.cancelContactAttempt.bind(this);
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

  inputListenerFactory(name) {
    return event => {
      const value = event.target.value;
      const formData = Object.assign(this.state.formData, { [name]: value });
      this.setState({ formData });
    };
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

    payload = Object.assign(payload, this.state.formData);

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
        currentUser={this.props.currentUser}
        apartment={apartment}
        building={building}
        assignAttempt={this.handleCreateContactAttempt}
        inputListenerFactory={this.inputListenerFactory}
      />
    );
  }
}

function mapStateToProps(state) {
  return {
    currentUser: state.currentUser,
    fetching: state.newContactAttempt.fetching,
    building: state.newContactAttempt.building,
    apartment: state.newContactAttempt.apartment,
    creating: state.newContactAttempt.creating,
    redirectTo: state.newContactAttempt.redirectTo
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
)(NewContactAttemptForm);
