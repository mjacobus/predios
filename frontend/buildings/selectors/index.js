const compactFilter = element => {
  return !!element;
};

const toString = value => {
  return value.toString().toLowerCase();
};

const filterByText = (buildings, filter) => {
  if (filter == "") {
    return buildings;
  }

  return buildings.filter(building => {
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

    return string.search(filter.toLowerCase()) >= 0;
  });
};

const filterByCallOption = (buildings, option) => {
  if (option == "all") {
    return buildings;
  }

  return buildings.filter(building => {
    return building.call_options.indexOf(option) >= 0;
  });
};

export const applyFilter = (buildings, filter) => {
  let filtered = buildings;

  if (filter.text) {
    filtered = filterByText(buildings, filter.text);
  }

  if (filter.callOption) {
    filtered = filterByCallOption(filtered, filter.callOption);
  }

  return filtered;
};
