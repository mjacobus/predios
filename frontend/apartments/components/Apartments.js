import React from "react";
import Apartment from "../../buildings/pages/show/Apartment";

const bellClick = apartment => {
  console.log("apartment bell -> ", apartment);
};

export default function Apartments({ apartments }) {
  if (!!!apartments) {
    return <span />;
  }

  return apartments.map(apartment => (
    <Apartment
      apartment={apartment}
      key={apartment.uuid}
      bellClick={() => bellClick(apartment)}
    />
  ));
}
