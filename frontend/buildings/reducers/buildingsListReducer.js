const DEFAULT_STATE = {
  fetching: true,
  buildings: [],
  filteredBuildings: []
};

const compactFilter = element => {
  return !!element;
};

const toString = value => {
  return value.toString().toLowerCase();
};

const filterBuildings = (buildings, filter) => {
  if (filter == "") {
    return buildings;
  }

  const filtered = buildings.filter(building => {
    const values = [
      building.number,
      building.address,
      building.neighborhood,
      building.name
    ];

    const string = values
      .filter(compactFilter)
      .map(toString)
      .join(" ");

    return string.search(filter) >= 0;
  });

  return filtered;
};

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
      buildings: action.buildings,
      fetching: false
    };
  }

  if (action.type == "BUILDINGS_FILTERED") {
    const filtered = filterBuildings(state.buildings, action.searchString);

    return {
      ...state,
      filter: action.searchString,
      filteredBuildings: filtered, // this is not working
      fetching: false
    };
  }

  return state;
}
