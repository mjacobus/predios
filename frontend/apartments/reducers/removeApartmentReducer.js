const DEFAULT_STATE = {
  apartment: null,
  building: null,
  deleting: false,
  error: null,
  fetching: true,
  redirectTo: null
};

export default function removeApartmentReducer(state = DEFAULT_STATE, action) {
  if (action.type == "APARTMENT_FETCH_ERROR") {
    return {
      ...state,
      error: action.message
    };
  }

  if (action.type == "APARTMENT_REMOVED") {
    return {
      ...state,
      redirectTo: `/buildings/${state.building.number}/apartments`
    };
  }

  if (action.type == "CLEAR_REDIRECT") {
    return { ...DEFAULT_STATE };
  }

  if (action.type == "FETCHING_APARTMENT") {
    return { ...DEFAULT_STATE };
  }

  if (action.type == "APARTMENT_FETCHED") {
    return {
      ...state,
      fetching: false,
      building: action.building,
      apartment: action.apartment
    };
  }

  return state;
}
