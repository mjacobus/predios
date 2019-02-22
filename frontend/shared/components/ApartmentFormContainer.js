import React from "react";
import { connect } from "react-redux";
import { css } from "glamor";

import Input from "../../library/Input";
import Button from "../../library/Button";
import FormRow from "../../library/FormRow";
import Float from "./Float";
import { createApartment } from "../../buildings/actions";
import { styles, colors } from "../../library/styles";

const inputClass = css({ width: "65%", marginRight: "15px" });

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
    this.props.createApartment(payload);
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
              className={inputClass}
              type="text"
            />
            <Float direction="right">
              <Button
                type="submit"
                disabled={props.loading}
                className={styles.button}
              >
                Adicionar
              </Button>
            </Float>
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

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(ApartmentForm);
