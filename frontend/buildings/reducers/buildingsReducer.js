export default function buildingsReducer(state = {}, action) {
  if (action.type == "BUILDINGS_FETCHED") {
    return action.buildings;
  }

  return state;
}
