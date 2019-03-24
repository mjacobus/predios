const DEFAULT_STATE = {
  building: undefined,
  deleting: false,
  error: null
};

export default function removeBuildingReducer(state = DEFAULT_STATE, action) {
  if (action.type == "BUILDING_FETCHED") {
    return {
      ...state,
      building: action.building
    };
  }

  if (action.type == "BUILDING_DELETE_ERROR") {
    return {
      ...state,
      error: action.message
    };
  }

  if (action.type == "BUILDING_DELETED") {
    return {
      ...state,
      redirectTo: `/buildings`
    };
  }

  if (action.type == "CLEAR_REDIRECT") {
    return { ...DEFAULT_STATE };
  }

  if (action.type == "DELETING_BUILDING") {
    return { ...action, deleting: true };
  }

  return state;
}
