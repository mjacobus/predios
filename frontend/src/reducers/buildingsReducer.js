export default function buildingsReduce(state = {}, action) {
  if (action.type == "BUILDINGS_FETCHED") {
    return action.buildings;
  }

  return state;
}
