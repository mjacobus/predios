import { filterBuildings } from "../selectors";

const DEFAULT_STATE = {
  fetching: true,
  buildings: [],
  filteredBuildings: []
};

export default function buildingsListReducer(state = DEFAULT_STATE, action) {
  if (action.type == "FETCHING_BUILDINGS") {
    return {
      ...state,
      fetching: true
    };
  }

  if (action.type == "BUILDINGS_FETCHED") {
    return {
      ...state,
      buildings: action.buildings,
      filteredBuildings: action.buildings,
      fetching: false
    };
  }

  if (action.type == "BUILDINGS_FILTERED") {
    const filtered = filterBuildings(state.buildings, action.searchString);

    return {
      ...state,
      filter: action.searchString,
      filteredBuildings: filtered, // this is not working
      fetching: false
    };
  }

  return state;
}
