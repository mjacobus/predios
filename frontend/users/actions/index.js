import { apiGet } from "../../src/utils/api.js";

const fetchUsers = dispatch => () => {
  dispatch({ type: "FETCHING_USERS" });

  return new Promise((resolve, reject) => {
    apiGet("/api/users").end((erro, resp) => {
      dispatch({
        type: "USERS_FETCHED",
        users: resp.body
      });

      resolve(resp.body);
    });
  });
};

const toggleMasterFlag = dispatch => (user) => {
  console.log('toggling master flat of ', user);
}

const toggleEnabledFlag = dispatch => (user) => {
  console.log('toggling enable flat of ', user);
}

export default {
  fetchUsers,
  toggleMasterFlag,
  toggleEnabledFlag,
};
