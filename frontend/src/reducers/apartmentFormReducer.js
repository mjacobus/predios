const DEFAULT_STATE = {
  building: null,
  loading: false,
  errors: null
};

export default function buildingsViewReducer(state = DEFAULT_STATE, action) {
  if (action.type == "CREATING_APARTMENT") {
    return {
      ...state,
      loading: true
    };
  }

  if (action.type == "APARTMENT_CREATED") {
    return {
      ...state,
      loading: false
    };
  }

  if (action.type == "APARTMENT_CREATION_FAILED") {
    return {
      ...state,
      loading: false,
      errors: action.errors
    };
  }

  return state;
}
