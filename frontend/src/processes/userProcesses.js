export function fetchCurrentUser() {
  return (dispatch, getState) => {
    dispatch({
      action: "USER_FETCHED",
      user: {}
    });
  };
}
