import buildings from "../../buildings/actions";

const fetchApartments = dispatch => {
  return ({ buildingNumber }) => {
    buildings.fetchBuildingByNumber(dispatch)(buildingNumber);
  };
};

export default {
  fetchApartments
};
