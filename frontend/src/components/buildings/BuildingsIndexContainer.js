import React from "react";

const mockApartment = number => {
  return {
    name: `Nome ${number}`,
    address: `The Address Foo Bar number ${number}`,
    neighborhood: `Bairro ${number}`,
    number: `Bairro ${number}`
  };
};

const mockBuildings = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10].map(i =>
  mockApartment(i)
);

const Apartment = ({ apartment }) => <div>{apartment.name}</div>;

const buildings = mockBuildings.map(apartment => (
  <Apartment apartment={apartment} />
));

export default function BuildingsIndexContainer() {
  return (
    <div>
      <h1>buildings</h1>
      {buildings}
    </div>
  );
}
