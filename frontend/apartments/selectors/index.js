const findApartmentByNumber = (apartments, number) => {
  const found = apartments.filter(apartment => {
    return apartment.number.toLowerCase() == number.toLowerCase();
  });

  if (found.length !== 1) {
    throw new Error("Apartment was not found");
  }

  return found.pop();
};

export { findApartmentByNumber };
