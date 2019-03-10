import { apiGet, apiPost, apiPatch } from "../../src/utils/api.js";

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

  return new Promise((resolve, reject) => {
    apiGet(`/api/buildings/${number}`).end((erro, resp) => {
      dispatch({
        type: "BUILDING_FETCHED",
        building: resp.body
      });

      resolve(resp.body);
    });
  });
};

export const attemptContactOn = dispatch => apartment => {
  dispatch({ type: "ATTEMPT_CONTACT_ON", apartment });
};

export const createApartment = dispatch => {
  return ({ building, number }) => {
    return new Promise((resolve, _reject) => {
      dispatch({ type: "CREATING_APARTMENT" });

      apiPost(`/api/buildings/${building.number}/apartments`)
        .send({
          apartment: { building_id: building.uuid, number }
        })
        .end((error, response) => {
          if (error) {
            return dispatch({
              type: "APARTMENT_CREATION_FAILED",
              errors: response.body
            });
          }

          dispatch({ type: "APARTMENT_CREATED" });
          fetchBuildingByNumber(dispatch)(building.number);
          resolve();
        });
    });
  };
};

export const filterBuildings = dispatch => {
  return filter => {
    dispatch({ type: "BUILDINGS_FILTERED", filter });
  };
};

const updateBuilding = dispatch => (uuid, changedAttributes) => {
  dispatch({ type: "UPDATING_BUILDING" });

  const payload = { building: changedAttributes };
  console.log(`Patching ${uuid} with:`, payload);

  return new Promise((resolve, reject) => {
    apiPatch(`/api/buildings/${uuid}`)
      .send(payload)
      .end((erro, resp) => {
        dispatch({ type: "BUILDING_UPDATED" });
        resolve(resp.body);
      });
  });
};

const createBuilding = dispatch => attributes => {
  dispatch({ type: "CREATING_BUILDING" });

  const payload = { building: attributes };
  console.log("Creating building with payload:", payload);

  return new Promise((resolve, reject) => {
    apiPost('/api/buildings')
      .send(payload)
      .end((erro, resp) => {
        dispatch({ type: "BUILDING_CREATED" });
        resolve(resp.body);
      });
  });
};

export { fetchBuildings, fetchBuildingByNumber, updateBuilding };

export default {
  fetchBuildingByNumber,
  updateBuilding,
  createBuilding
};
