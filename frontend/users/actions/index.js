import { apiGet, apiPost, apiDelete } from "../../src/utils/api.js";

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

const toggleMasterFlag = dispatch => user => {
  const request = user.master ? apiDelete : apiPost;

  request(`/api/users/${user.id}/master`).end((error, resp) => {
    const replacement = Object.assign({}, user, { master: !user.master });
    dispatch({ type: "USER_REPLACED", user: replacement });
  });
};

const toggleEnabledFlag = dispatch => user => {
  const request = user.enabled ? apiDelete : apiPost;

  request(`/api/users/${user.id}/enable`).end((error, resp) => {
    const replacement = Object.assign({}, user, { enabled: !user.enabled });
    dispatch({ type: "USER_REPLACED", user: replacement });
  });
};

export default {
  fetchUsers,
  toggleMasterFlag,
  toggleEnabledFlag
};
