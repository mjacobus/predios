import React from "react";

const Apartment = ({ apartment }) => <div>{apartment.name}</div>;

export default function BuildingsIndex(props) {
  const buildings = props.buildings;
  return (
    <div>
      <h1>buildings</h1>
      {buildings.map((apartment, i) => (
        <Apartment apartment={apartment} key={i} />
      ))}
    </div>
  );
}
