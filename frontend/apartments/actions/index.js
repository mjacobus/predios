import { apiDelete } from "../../src/utils/api.js";
import buildings from "../../buildings/actions";
import { findApartmentByNumber } from "../selectors";

const fetchApartments = dispatch => {
  return ({ buildingNumber }) => {
    buildings.fetchBuildingByNumber(dispatch)(buildingNumber);
  };
};

const fetchApartment = dispatch => {
  return ({ buildingNumber, apartmentNumber }) => {
    dispatch({ type: "FETCHING_APARTMENT" });
    buildings
      .fetchBuildingByNumber(dispatch)(buildingNumber)
      .then(building => {
        dispatch({
          type: "APARTMENT_FETCHED",
          building: building,
          apartment: findApartmentByNumber(building.apartments, apartmentNumber)
        });
      })
      .catch(e => {
        dispatch({
          type: "APARTMENT_FETCH_ERROR",
          message: "Apartamento não encontrado"
        });
      });
  };
};

const removeApartment = dispatch => ({ building, apartment }) => {
  // at the moment building id is irelevant
  apiDelete(`/api/buildings/${building.uuid}/apartments/${apartment.uuid}`).end(
    (error, response) => {
      dispatch({ type: "APARTMENT_REMOVED" });
    }
  );
};

export default {
  fetchApartments,
  removeApartment,
  fetchApartment
};
