import React from "react";
import { connect } from "react-redux";
import { Input } from "../library/html";
import { createApartment } from "../../actions/buildingsActions";

function mapStateToProps(state) {
  return {
    building: state.buildingView.building,
    loading: state.apartmentForm.loading,
    errors: state.apartmentForm.errors
  };
}

function mapDispatchToProps(dispatch) {
  return {
    createApartment: createApartment(dispatch)
  };
}

class ApartmentForm extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      apartment: {}
    };
    this.submitHandler = this.submitHandler.bind(this);
  }

  setValue(field) {
    let apartment = this.state.apartment;

    return e => {
      apartment = Object.assign({}, apartment, { [field]: e.target.value });
      this.setState({ apartment });
    };
  }

  submitHandler(e) {
    e.preventDefault();
    const { building } = this.props;
    const { number } = this.state.apartment;
    const payload = { building, number };
    this.props.createApartment(payload);
  }

  render() {
    const props = this.props;

    return (
      <div>
        <form onSubmit={this.submitHandler}>
          <div>
            <Input
              placeholder="número do apartamento"
              onChange={this.setValue("number")}
              disabled={props.loading}
              type="text"
            />
            {props.errors && <small>{props.errors.message}</small>}
          </div>
          {props.loading || <Input type="submit" value="Submit" />}
        </form>
      </div>
    );
  }
}

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(ApartmentForm);
