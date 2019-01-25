import { connect } from "react-redux";
import BuildingsIndex from "./BuildingsIndex";

function mapStateToProps(state) {
  return {
    buildings: state.entities.buildings
  };
}

function mapDispatchToProps(dispatch) {
  return {
    fetchBuildings: params => {}
  };
}

const BuildingsIndexContainer = connect(
  mapStateToProps,
  mapDispatchToProps
)(BuildingsIndex);

export default BuildingsIndexContainer;
