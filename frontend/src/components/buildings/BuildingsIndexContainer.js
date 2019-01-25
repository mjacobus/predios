import React from "react";
import { connect } from "react-redux";
import BuildingsIndex from "./BuildingsIndex";
import { fetchBuildings } from "../../actions/buildingsActions";

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

class BuildingsContainer extends React.Component {
  constructor(props) {
    super(props);
    this.fetchBuildings = this.fetchBuildings.bind(this);
  }

  componentDidMount() {
    this.fetchBuildings();
  }

  fetchBuildings() {
    this.props.fetchBuildings();
  }

  render() {
    const { buildings, currentUser, fetching } = this.props;
    const props = { buildings, currentUser, fetching };
    return <BuildingsIndex {...props} />;
  }
}

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(BuildingsContainer);
