import React from "react";
import { connect } from "react-redux";
import List from "./List";
import { fetchBuildings } from "../actions";
import { debug } from "../../src/utils/log";

function mapStateToProps(state) {
  return {
    buildings: state.buildingsList.buildings,
    fetching: state.buildingsList.fetching,
    currentUser: state.currentUser
  };
}

function mapDispatchToProps(dispatch) {
  return {
    fetchBuildings: fetchBuildings(dispatch)
  };
}

const compactFilter = element => {
  return !!element;
};

const toString = value => {
  return value.toString().toLowerCase();
};

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

  filteredBuildings(buildings) {
    const filter = this.state.filter;

    if (filter == "") {
      return buildings;
    }

    return buildings.filter(building => {
      const values = [
        building.number,
        building.address,
        building.neighborhood,
        building.name
      ];

      const string = values
        .filter(compactFilter)
        .map(toString)
        .join(" ");

      return string.search(filter) >= 0;
    });
  }

  render() {
    const props = Object.assign({}, this.props);
    const buildings = this.props.buildings || [];
    return <List buildings={buildings} />;
  }
}

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(BuildingsContainer);
