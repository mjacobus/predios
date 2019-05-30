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
    this.submitHandler = this.submitHandler.bind(
      this
    );
    // this.inputListenerFactory = this.inputListenerFactory.bind(this);
    // this.cancelContactAttempt = this.cancelContactAttempt.bind(this);
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

  onCheckboxChange(event) {
    console.log(event)
    // return event => {
    //   const value = event.target.value;
    //   const formData = Object.assign(this.state.formData, { [name]: value });
    //   this.setState({ formData });
    // };
  }

  componentWillUnmount() {
    this.props.clearRedirect();
  }

  submitHandler(apartment, outcome) {
    // const { building } = this.props;
    // let payload = {
    //   building,
    //   apartment,
    //   outcome
    // };
    //
    // payload = Object.assign(payload, this.state.formData);
    //
    // this.props.createContactAttempt(payload);
  }

  // cancelContactAttempt() {
  //   this.props.attemptContactOn(null);
  // }

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
        submitHandler={this.submitHandler}
        assignAttempt={this.handleCreateContactAttempt}
        inputListenerFactory={this.inputListenerFactory}
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
