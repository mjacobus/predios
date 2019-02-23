import React from "react";
import { connect } from "react-redux";
import { fetchBuildings } from "../actions";
import { Loader } from "../../library";
import Filter from "./list/FilterContainer";
import Building from "./list/Building";

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

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(BuildingsContainer);
