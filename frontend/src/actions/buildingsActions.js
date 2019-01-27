import { apiGet } from "../utils/api.js";

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
