import React from "react";
import Loader from "../library/Loader";

const Apartment = ({ apartment }) => <div>{apartment.name}</div>;

export default function BuildingsIndex(props) {
  const { buildings, currentUser, fetching } = props;
  return (
    <div>
      <h1>Prédios</h1>
      {fetching && <Loader />}
      {fetching ||
        buildings.map((apartment, i) => (
          <Apartment apartment={apartment} key={i} />
        ))}
    </div>
  );
}
