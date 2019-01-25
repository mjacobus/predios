const fetchBuildings = (dispatch) => ()  => {
  dispatch({
    type: 'BUILDINGS_FETCHED',
    publications: [
      {
        name: "Publication 1"
      },
      {
        name: "Publication 2"
      },
    ]
  })
};
export {
  fetchBuildings,
}
