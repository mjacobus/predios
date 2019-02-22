import React from "react";
import { connect } from "react-redux";
import actions from "../actions";
import { Loader } from "../../library";
import Buildings from "../components";

class EditContainer extends React.Component {
  componentDidMount() {
    const { buildingNumber } = this.props.match.params;
    // this.props.fetchBuildingByNumber(buildingNumber);
  }

  render() {
    const { building, fetching, updating } = this.props;

    // if (fetching) {
    //   return <Loader />;
    // }

    return <Buildings.Form building={building} updating={updating} />;
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
