import React from "react";
import { connect } from "react-redux";
import BuildingView from "./BuildingView";
import { debug } from "../../utils/log";
import { Redirect } from "react-router";
import {
  fetchBuildingByNumber,
  createContactAttempt
} from "../../actions/buildingsActions";

function mapStateToProps(state) {
  return {
    building: state.buildingView.building,
    fetching: state.buildingView.fetching,
    reload: state.buildingView.reload
  };
}

function mapDispatchToProps(dispatch) {
  return {
    createContactAttempt: createContactAttempt(dispatch),
    fetchBuildingByNumber: fetchBuildingByNumber(dispatch)
  };
}

class BuildingViewContainer extends React.Component {
  constructor(props) {
    super(props);
  }

  componentDidMount() {
    this.reload();
  }

  reload() {
    const { number } = this.props.match.params;
    this.props.fetchBuildingByNumber(number);
  }

  render() {
    if (this.props.reload) {
      this.reload();
    }

    const {
      fetching,
      building,
      contactAttemptCreated,
      ...otherProps
    } = this.props;

    if (contactAttemptCreated) {
      return <Redirect to={`/app/buildings/${building.number}`} />;
    }

    return (
      <BuildingView building={building} fetching={fetching} {...otherProps} />
    );
  }
}

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(BuildingViewContainer);
