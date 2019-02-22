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
    const filtered = applyFilter(action.buildings, state.filter);

    return {
      ...state,
      buildings: action.buildings,
      filteredBuildings: filtered,
      fetching: false
    };
  }

  if (action.type == "BUILDINGS_FILTERED") {
    const filtered = applyFilter(state.buildings, action.filter);

    return {
      ...state,
      filter: action.filter,
      filteredBuildings: filtered,
      fetching: false
    };
  }

  return state;
}
