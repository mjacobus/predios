const DEFAULT_STATE = {
  fetching: true,
  building: null,
  reload: null,
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
      reload: false,
      fetching: false
    };
  }

  if (action.type == "CREATING_CONTACT_ATTEMPT") {
    return {
      ...state,
      fetching: true
    };
  }

  if (action.type == "CONTACT_ATTEMPT_CREATED") {
    console.log('reloadeeeeeeeeeed')
    return {
      ...state,
      reload: true,
    };
  }

  return state;
}
