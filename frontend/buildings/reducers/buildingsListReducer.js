import { applyFilter } from "../selectors";

const DEFAULT_STATE = {
  fetching: true,
  filter: { callOption: "all", text: "" },
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
    const filtered = applyFilter(state.buildings, action.filter);

    return {
      ...state,
      filter: action.filter,
      filteredBuildings: filtered, // this is not working
      fetching: false
    };
  }

  return state;
}
