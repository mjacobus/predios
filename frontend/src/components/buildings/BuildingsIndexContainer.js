import React from "react";
import { connect } from "react-redux";
import BuildingsIndex from "./BuildingsIndex";
import { fetchBuildings } from "../../actions/buildingsActions";

function mapStateToProps(state) {
  return {
    buildings: state.entities.buildings
  };
}

function mapDispatchToProps(dispatch) {
  return {
    fetchBuildings: fetchBuildings(dispatch),
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
    return <BuildingsIndex buildings={this.props.buildings} />;
  }
}

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(BuildingsContainer);
