const DEFAULT_STATE = {
  building: null,
  fetching: true,
  updating: false,
  redirectTo: null
};

const apartmentsUrl = state => {
  const { building } = state;
  return `/buildings/${building.number}/apartments`;
};

export default function editBuildingReducer(state = DEFAULT_STATE, action) {
  if (action.type == "BUILDING_FETCHED") {
    return {
      ...state,
      building: action.building,
      fetching: false
    };
  }

  if (action.type == "FETCHING_BUILDING") {
    return {
      ...state,
      building: null,
      fetching: true
    };
  }

  if (action.type == "UPDATING_BUILDING") {
    return {
      ...state,
      updating: true
    };
  }

  if (action.type == "BUILDING_UPDATED") {
    return Object.assign({}, DEFAULT_STATE, {
      redirectTo: apartmentsUrl(state)
    });
  }

  if (action.type == "CLEAR_REDIRECT") {
    return Object.assign({}, DEFAULT_STATE);
  }

  return state;
}
