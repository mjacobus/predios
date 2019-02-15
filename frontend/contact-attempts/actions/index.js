import buildings from "../../buildings/actions"

const fetchApartmentByBuildingNumber = (dispatch) => {
  return ({ buildingNumber, apartmentNumber }) => {
    buildings.fetchBuildingByNumber(dispatch)(buildingNumber).then(buildings => {
      const apartment = buildings.apartments
        .filter(apartment => apartment.number == apartmentNumber)
        .pop()

      if (!apartment) {
        throw new Error('Apartment not found');
      }

      dispatch({ type: 'APARTMENT_FETCHED', apartment })
    });
  }
}

export default {
  fetchApartmentByBuildingNumber,
}
