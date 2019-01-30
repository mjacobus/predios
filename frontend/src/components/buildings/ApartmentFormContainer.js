import React from "react";
import { connect } from "react-redux";
import { Input, Button } from "../library/html";
import { createApartment } from "../../actions/buildingsActions";
import { styles, colors } from "../library/styles";
import { css } from "glamor";

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
      <div className={styles.formContainer}>
        <form onSubmit={this.submitHandler}>
          <div>
            <Input
              placeholder="número"
              onChange={this.setValue("number")}
              disabled={props.loading}
              className={css({ width: "65%", marginRight: "15px" })}
              type="text"
            />
            <Button
              type="submit"
              disabled={props.loading}
              className={styles.button}
            >
              Adicionar
            </Button>
            <div>
              <small className={css({ color: colors.red })}>
                {props.errors && props.errors.message}&nbsp;
              </small>
            </div>
          </div>
        </form>
      </div>
    );
  }
}

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(ApartmentForm);
