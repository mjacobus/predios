export default function buildingsListReducer(state = {}, action) {
  if (action.type == "FETCHING_BUILDINGS") {
    return {
      ...state,
      fetching: true
    };
  }

  if (action.type == "BUILDINGS_FETCHED") {
    return {
      ...state,
      fetching: false
    };
  }

  return state;
}
