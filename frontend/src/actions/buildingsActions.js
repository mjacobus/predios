import { apiGet } from '../utils/api.js';

const fetchBuildings = (dispatch) => ()  => {
  apiGet("/api/buildings").end((erro, resp) => {
    dispatch({
      type: 'BUILDINGS_FETCHED',
      buildings: resp.body
    })
  });
};
export {
  fetchBuildings,
}
