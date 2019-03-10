const DEFAULT_STATE = {
  fetching: true,
  creating: false,
  redirectTo: null
};

export default function editBuildingReducer(state = DEFAULT_STATE, action) {
  if (action.type == "CREATING_BUILDING") {
    return {
      ...state,
      updating: true
    };
  }

  if (action.type == "BUILDING_CREATED") {
    return Object.assign({}, DEFAULT_STATE, {
      redirectTo: "/buildings"
    });
  }

  if (action.type == "CLEAR_REDIRECT") {
    return Object.assign({}, DEFAULT_STATE);
  }

  return state;
}
