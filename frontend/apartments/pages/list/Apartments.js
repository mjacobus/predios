import React from "react";
import Apartment from "../../../buildings/pages/show/Apartment";

export default function Apartments({ apartments, building }) {
  if (!apartments) {
    return <span />;
  }

  return apartments.map(apartment => (
    <Apartment building={building} apartment={apartment} key={apartment.uuid} />
  ));
}
