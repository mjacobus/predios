import buildings from "../../buildings/actions";

import { apiPost, apiDelete } from "../../src/utils/api.js";

const fetchApartmentByBuildingNumber = dispatch => {
  return ({ buildingNumber, apartmentNumber }) => {
    buildings
      .fetchBuildingByNumber(dispatch)(buildingNumber)
      .then(buildings => {
        const apartment = buildings.apartments
          .filter(apartment => apartment.number == apartmentNumber)
          .pop();

        if (!apartment) {
          throw new Error("Apartment not found");
        }

        dispatch({ type: "APARTMENT_FETCHED", apartment });
      });
  };
};

const removeContactAttempts = dispatch => ({
  contactAttempts,
  building,
  apartment
}) => {
  dispatch({ type: "REMOVE_CONTACT_ATTEMPTS" });
  const payload = { contact_attempts: contactAttempts };

  apiDelete(
    `/api/buildings/${building.uuid}/apartments/${
      apartment.uuid
    }/contact_attempts`
  )
    .send(payload)
    .end((error, resp) => {
      if (error) {
        throw new Error(error);
      }

      dispatch({ type: "CONTACT_ATTEMPTS_REMOVED" });
    });
};

const createContactAttempt = dispatch => ({
  building,
  apartment,
  outcome,
  type,
  time
}) => {
  dispatch({ type: "CREATING_CONTACT_ATTEMPT" });

  const payload = {
    contact_attempt: { apartment_id: apartment.uuid, outcome, time, type }
  };

  if (time == "") {
    delete payload.contact_attempt.time;
  }

  apiPost(
    `/api/buildings/${building.number}/apartments/${
      apartment.id
    }/assign_visit_attempt`
  )
    .send(payload)
    .end((error, resp) => {
      if (error) {
        throw new Error(error);
      }

      dispatch({ type: "CONTACT_ATTEMPT_CREATED" });
      buildings.fetchBuildingByNumber(dispatch)(building.number);
    });
};

export default {
  fetchApartmentByBuildingNumber,
  createContactAttempt,
  removeContactAttempts
};
