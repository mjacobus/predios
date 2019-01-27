const DEFAULT_STATE = {
  fetching: true,
  building: null
};

export default function buildingsViewReducer(state = DEFAULT_STATE, action) {
  if (action.type == "FETCHING_BUILDING") {
    return {
      ...state,
      fetching: true
    };
  }

  if (action.type == "BUILDING_FETCHED") {
    return {
      ...state,
      building: action.building,
      fetching: false
    };
  }

  return state;
}
