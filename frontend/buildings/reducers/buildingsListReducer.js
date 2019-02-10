const DEFAULT_STATE = {
  fetching: true,
  buildings: []
};

export default function buildingsListReducer(state = {}, action) {
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
      fetching: false
    };
  }

  return state;
}
