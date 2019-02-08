import React from "react";
import { connect } from "react-redux";
import BuildingsIndex from "./List";
import { fetchBuildings } from "../actions";
import { debug } from "../../src/utils/log";

function mapStateToProps(state) {
  return {
    fetching: state.buildingsList.fetching,
    currentUser: state.currentUser,
    buildings: state.entities.buildings
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
    this.fetchBuildings = this.fetchBuildings.bind(this);
    this.filter = this.filter.bind(this);
    this.state = {
      filter: ""
    };
  }

  componentDidMount() {
    this.fetchBuildings();
  }

  fetchBuildings() {
    this.props.fetchBuildings();
  }

  filter(filter) {
    this.setState({ filter: filter.toString().toLowerCase() });
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
    const { buildings, currentUser, fetching } = this.props;
    const props = { currentUser, fetching };
    props.filter = this.filter;
    props.buildings = this.filteredBuildings(buildings);
    debug(`Filtered with ${this.state.filter}`, props.buildings);
    return <BuildingsIndex {...props} />;
  }
}

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(BuildingsContainer);
