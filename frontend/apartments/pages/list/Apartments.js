import React from "react";
import Apartment from "./ApartmentContainer";

export default function Apartments({ apartments, building }) {
  if (!apartments) {
    return <span />;
  }

  return apartments.map(apartment => (
    <Apartment building={building} apartment={apartment} key={apartment.uuid} />
  ));
}
