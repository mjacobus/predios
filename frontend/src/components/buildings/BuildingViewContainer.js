import React from "react";
import { connect } from "react-redux";
import BuildingView from "./BuildingView";
import { fetchBuildingByNumber } from "../../actions/buildingsActions";
import { debug } from "../../utils/log";

function mapStateToProps(state) {
  return {
    building: state.buildingView.building,
    fetching: state.buildingView.fetching
  };
}

function mapDispatchToProps(dispatch) {
  return {
    fetchBuildingByNumber: fetchBuildingByNumber(dispatch)
  };
}

class BuildingViewContainer extends React.Component {
  constructor(props) {
    super(props);
  }

  componentDidMount() {
    const { number } = this.props.match.params;
    this.props.fetchBuildingByNumber(number);
  }

  render() {
    const { fetching, building } = this.props;
    return <BuildingView building={building} fetching={fetching} />;
  }
}

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(BuildingViewContainer);
