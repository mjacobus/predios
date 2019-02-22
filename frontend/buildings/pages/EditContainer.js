import React from "react";
import { connect } from "react-redux";
import actions from "../actions";

class EditContainer extends React.Component {
  componentDidMount() {
    const { buildingNumber } = this.props.match.params;
    this.props.fetchBuildingByNumber(buildingNumber);
  }

  render() {
    if (this.props.building) {
      return <p>Editing building {this.props.building.number}</p>;
    }

    return <p>Nothing yet</p>;
  }
}

function mapStateToProps(state) {
  return {
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
