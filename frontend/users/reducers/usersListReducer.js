const DEFAULT_STATE = {
  fetching: true,
  users: []
};

export default function usersListReducer(state = DEFAULT_STATE, action) {
  if (action.type == "FETCHING_USERS") {
    return {
      ...state,
      fetching: true
    };
  }

  if (action.type == "USERS_FETCHED") {
    return {
      ...state,
      fetching: false,
      users: action.users
    };
  }

  return state;
}
