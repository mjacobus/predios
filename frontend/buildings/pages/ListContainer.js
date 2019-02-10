import React from "react";
import { connect } from "react-redux";
import List from "./List";
import { fetchBuildings } from "../actions";
import { Loader } from "../../library";
import Filter from "./list/FilterContainer";
import Building from "./list/Building";
import { H1 } from "../../library";

function mapStateToProps(state) {
  return {
    buildings: state.buildingsList.buildings,
    filteredBuildings: state.buildingsList.filteredBuildings,
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
    this.props.fetchBuildings();
  }

  render() {
    const buildings = this.props.filteredBuildings;
    const { filter, fetching } = this.props;

    return (
      <div>
        <H1>Edifícios</H1>
        <Filter />
        {fetching && <Loader />}
        {fetching ||
          buildings.map((building, i) => (
            <Building building={building} key={i} />
          ))}
      </div>
    );
  }
}

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(BuildingsContainer);
