import React from "react";
import { connect } from "react-redux";
import List from "./List";
import { fetchBuildings } from "../actions";
import { debug } from "../../src/utils/log";

function mapStateToProps(state) {
  return {
    buildings: state.buildingsList.buildings,
    filteredBuildings: state.buildingsList.buildings,
    fetching: state.buildingsList.fetching,
    currentUser: state.currentUser
  };
}

function mapDispatchToProps(dispatch) {
  return {
    fetchBuildings: fetchBuildings(dispatch)
  };
}

class BuildingsContainer extends React.Component {
  constructor(props) {
    super(props);
  }

  componentDidMount() {
    this.fetchBuildings();
  }

  fetchBuildings() {
    this.props.fetchBuildings();
  }

  render() {
    const buildings = this.props.filteredBuildings || [];
    return <List buildings={buildings} />;
  }
}

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(BuildingsContainer);
