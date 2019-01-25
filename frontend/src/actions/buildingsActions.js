import { apiGet } from '../utils/api.js';

const fetchBuildings = (dispatch) => ()  => {
  apiGet("/api/buildings").then(resp => console.log(resp));

  dispatch({
    type: 'BUILDINGS_FETCHED',
    buildings: [
      {
        name: "Building 1"
      },
      {
        name: "Building 2"
      },
    ]
  })
};
export {
  fetchBuildings,
}
