const DEFAULT_STATE = {
  fetching: true,
  redirect: null,
  removing: null,
  building: null,
  apartment: null,
  building: null
};

const apartmentsUrl = state => {
  const { building } = state;

  return `/buildings/${building.number}/apartments`;
};

export default function(state = DEFAULT_STATE, action) {
  if (action.type == "BUILDING_FETCHED") {
    return {
      ...state,
      building: action.building
    };
  }

  if (action.type == "APARTMENT_FETCHED") {
    return {
      ...state,
      fetching: false,
      apartment: action.apartment
    };
  }

  if (action.type == "REMOVE_CONTACT_ATTEMPTS") {
    return {
      ...state,
      removing: true
    };
  }

  if (action.type == "CONTACT_ATTEMPTS_REMOVED") {
    return Object.assign({}, DEFAULT_STATE, {
      redirectTo: apartmentsUrl(state)
    });
  }

  if (action.type == "CLEAR_REDIRECT") {
    return Object.assign({}, DEFAULT_STATE);
  }

  return state;
}
