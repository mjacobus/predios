const compactFilter = element => {
  return !!element;
};

const toString = value => {
  return value.toString().toLowerCase();
};

export const filterBuildings = (buildings, filter) => {
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
