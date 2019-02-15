const DEFAULT_STATE = {
  building: null,
  apartments: null,
  fetching: true
};

export default (state = DEFAULT_STATE, action) => {
  if (action.type == "BUILDING_FETCHED") {
    return {
      ...state,
      building: action.building,
      apartments: action.building.apartments,
      fetching: false
    };
  }

  return state;
};
