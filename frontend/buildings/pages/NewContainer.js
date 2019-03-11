import React from "react";

import { connect } from "react-redux";
import { Redirect } from "react-router-dom";
import actions from "../actions";
import { clearRedirect } from "../../shared/actions";
import { Loader, H1 } from "../../library";
import Buildings from "../components";

class NewContainer extends React.Component {
  constructor(props) {
    super(props);
    this.onAttributeChange = this.onAttributeChange.bind(this);
    this.submitHandler = this.submitHandler.bind(this);
    this.state = { formData: {} };
  }

  onAttributeChange(name, value) {
    const { formData } = this.state;
    formData[name] = value;
    this.setState({ formData });
    console.log(this.state);
  }

  submitHandler(event) {
    event.preventDefault();
    this.props.createBuilding(this.state.formData);
  }

  render() {
    const { creating, redirectTo } = this.props;

    if (redirectTo) {
      return <Redirect to={redirectTo} />;
    }

    const { onAttributeChange, submitHandler } = this;

    return (
      <>
        <H1>Criação de Prédio</H1>
        <Buildings.Form
          errors={this.props.formErrors}
          onSubmit={submitHandler}
          onAttributeChange={onAttributeChange}
          building={{}}
          updating={creating}
        />
      </>
    );
  }
}

function mapStateToProps(state) {
  return {
    redirectTo: state.newBuilding.redirectTo,
    formErrors: state.newBuilding.formErrors,
    creating: state.newBuilding.creating
  };
}

function mapDispatchToProps(dispatch) {
  return {
    clearRedirect: clearRedirect(dispatch),
    createBuilding: actions.createBuilding(dispatch)
  };
}

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(NewContainer);
