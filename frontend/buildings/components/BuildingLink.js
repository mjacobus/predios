import React from "react";

const BuildingLink = props => {
  const label = props.children || props.number;
  return <A to={`/buildings/${props.number}`}>{label}</A>;
};

export default BuildingLink;
