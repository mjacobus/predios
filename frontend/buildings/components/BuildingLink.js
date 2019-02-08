import React from "react";

export default function BuildingLink(props) {
  const label = props.children || props.number;
  return <A to={`/buildings/${props.number}`}>{label}</A>;
}
