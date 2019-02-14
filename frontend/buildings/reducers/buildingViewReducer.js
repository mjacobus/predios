const DEFAULT_STATE = {
  building: null,
  contactAttemptTime: null,
  creatingApartment: null,
  creatingContactAttempt: null,
  fetching: true,
  contactAttemptOn: null
};

export default function buildingViewReducer(state = DEFAULT_STATE, action) {
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
      creatingContactAttempt: true
    };
  }

  if (action.type == "CONTACT_ATTEMPT_CREATED") {
    return {
      ...state,
      creatingContactAttempt: null,
      contactAttemptOn: null
    };
  }

  if (action.type == "CONTACT_ATTEMPT_TIME_CHANGED") {
    return {
      ...state,
      contactAttemptTime: action.time
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
