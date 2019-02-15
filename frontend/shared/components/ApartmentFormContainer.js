import React from "react";
import { connect } from "react-redux";
import { css } from "glamor";

import { Input, Button, FormRow } from "../../library";
import { createApartment } from "../../buildings/actions";
import { styles, colors } from "../../library/styles";

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
      apartment: { number: "" }
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
    this.props.createApartment(payload).then(() => {
      this.setState({ apartment: { number: "" } });
    });
  }

  render() {
    const props = this.props;

    if (this.props.building.has_all_apartments) {
      return <span />;
    }

    return (
      <div className={styles.formContainer}>
        <form onSubmit={this.submitHandler}>
          <FormRow>
            <Input
              autoFocus={true}
              placeholder="Número do Apartamento"
              onChange={this.setValue("number")}
              disabled={props.loading}
              value={this.state.apartment.number}
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
                {props.errors && props.errors.message}
              </small>
            </div>
          </FormRow>
        </form>
      </div>
    );
  }
}

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(ApartmentForm);