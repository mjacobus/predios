import React from "react";
import { connect } from "react-redux";
import { Redirect } from "react-router-dom";
import actions from "../actions";
import { clearRedirect } from "../../shared/actions";
import { Loader, H1 } from "../../library";
import Buildings from "../components";

class EditContainer extends React.Component {
  constructor(props) {
    super(props);
    this.onAttributeChange = this.onAttributeChange.bind(this);
    this.submitHandler = this.submitHandler.bind(this);
    this.state = { formData: {} };
  }

  componentWillUnmount() {
    this.props.clearRedirect();
  }

  componentDidMount() {
    const { buildingNumber } = this.props.match.params;
    this.props.fetchBuildingByNumber(buildingNumber);
  }

  onAttributeChange(name, value) {
    const { formData } = this.state;
    formData[name] = value;
    this.setState({ formData });
  }

  submitHandler(event) {
    event.preventDefault();
    const { building } = this.props;
    this.props.updateBuilding(building.uuid, this.state.formData);
  }

  render() {
    const { building, fetching, updating, redirectTo } = this.props;

    if (redirectTo) {
      return <Redirect to={redirectTo} />;
    }

    if (fetching) {
      return <Loader />;
    }

    const { onAttributeChange, submitHandler } = this;
    return (
      <>
        <H1>Alteração de Prédio</H1>
        <Buildings.Form
          onSubmit={submitHandler}
          onAttributeChange={onAttributeChange}
          building={building}
          updating={updating}
        />
      </>
    );
  }
}

function mapStateToProps(state) {
  return {
    redirectTo: state.editBuilding.redirectTo,
    updating: state.editBuilding.updating,
    fetching: state.editBuilding.fetching,
    building: state.editBuilding.building
  };
}

function mapDispatchToProps(dispatch) {
  return {
    clearRedirect: clearRedirect(dispatch),
    updateBuilding: actions.updateBuilding(dispatch),
    fetchBuildingByNumber: actions.fetchBuildingByNumber(dispatch)
  };
}

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(EditContainer);
