const DEFAULT_STATE = {
  fetching: true,
  building: null,
  contactAttemptOn: null
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
      fetching: false,
      contactAttemptOn: null
    };
  }

  if (action.type == "CREATING_CONTACT_ATTEMPT") {
    return {
      ...state,
      fetching: true
    };
  }

  if (action.type == "CONTACT_ATTEMPT_CREATED") {
    return {
      ...state,
      contactAttemptOn: null
    };
  }

  if (action.type == "ATTEMPT_CONTACT_ON") {
    return {
      ...state,
      contactAttemptOn: action.apartment
    };
  }

  return state;
}
