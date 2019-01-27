import React from "react";
import Loader from "../library/Loader";

export default function BuildingView(props) {
  const { fetching, building } = props;

  if (fetching) {
    return <Loader />;
  }

  return <h1>{building.name}</h1>;
}
