export default function currentUserReducer(state = {}, action) {
  let newState = state;
  switch (action.type) {
    case 'USER_FETCHED':
      newState = action.user;
    default:
      return newState;
  }
}
