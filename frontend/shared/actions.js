export function clearRedirect(dispatch) {
  return () => {
    dispatch({ type: "CLEAR_REDIRECT" });
  };
}
