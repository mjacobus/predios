import { apiGet, apiPost } from "../utils/api.js";

const fetchBuildings = dispatch => () => {
  dispatch({ type: "FETCHING_BUILDINGS" });

  apiGet("/api/buildings").end((erro, resp) => {
    dispatch({
      type: "BUILDINGS_FETCHED",
      buildings: resp.body
    });
  });
};

const fetchBuildingByNumber = dispatch => number => {
  dispatch({ type: "FETCHING_BUILDING" });

  apiGet(`/api/buildings/${number}`).end((erro, resp) => {
    dispatch({
      type: "BUILDING_FETCHED",
      building: resp.body
    });
  });
};

export { fetchBuildings, fetchBuildingByNumber };

export const attemptContactOn = dispatch => apartment => {
  dispatch({ type: "ATTEMPT_CONTACT_ON", apartment });
};

export const createContactAttempt = dispatch => ({
  building,
  apartment,
  outcome
}) => {
  dispatch({ type: "CREATING_CONTACT_ATTEMPT" });

  const payload = {
    contact_attempt: { apartment_id: apartment.uuid, outcome }
  };

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
      fetchBuildingByNumber(dispatch)(building.number);
    });
};
