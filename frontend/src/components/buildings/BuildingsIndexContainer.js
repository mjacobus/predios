import { connect } from "react-redux";
import BuildingsIndex from "./BuildingsIndex";

const mockApartment = number => {
  return {
    name: `Nome ${number}`,
    address: `The Address Foo Bar number ${number}`,
    neighborhood: `Bairro ${number}`,
    number: `Bairro ${number}`
  };
};

function mapStateToProps(state) {
  return {
    // buildings: state.entities.buildings,
    buildings: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10].map(i => mockApartment(i))
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
