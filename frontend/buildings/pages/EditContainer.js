import React from "react";
import { connect } from "react-redux";
import actions from "../actions";
import { Loader } from "../../library";
import Buildings from "../components";

class EditContainer extends React.Component {
  constructor(props) {
    super(props);
    this.onAttributeChange = this.onAttributeChange.bind(this);
    this.state = { formData: {} };
  }

  componentDidMount() {
    const { buildingNumber } = this.props.match.params;
    this.props.fetchBuildingByNumber(buildingNumber);
  }

  onAttributeChange(name, value) {
    const { formData } = this.state;
    formData[name] = value;
    this.setState({ formData });
    console.log(this.state);
  }

  render() {
    const { building, fetching, updating } = this.props;

    if (fetching) {
      return <Loader />;
    }

    const { onAttributeChange } = this;
    return (
      <Buildings.Form
        onAttributeChange={onAttributeChange}
        building={building}
        updating={updating}
      />
    );
  }
}

function mapStateToProps(state) {
  return {
    fetching: state.editBuilding.fetching,
    building: state.editBuilding.building
  };
}

function mapDispatchToProps(dispatch) {
  return {
    fetchBuildingByNumber: actions.fetchBuildingByNumber(dispatch)
  };
}

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(EditContainer);
