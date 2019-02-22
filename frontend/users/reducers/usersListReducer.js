const DEFAULT_STATE = {
  fetching: true,
  users: []
};

const replaceUser = (users, replacement) => {
  const replacements = [];

  users.forEach(user => {
    if (user.id == replacement.id) {
      user = replacement;
    }

    replacements.push(user);
  });

  return replacements;
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

  if (action.type == "USER_REPLACED") {
    return {
      ...state,
      fetching: false,
      users: replaceUser(state.users, action.user)
    };
  }

  return state;
}
