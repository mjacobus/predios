import React from "react";
import { A } from "../../library";

export default function BuildingLink(props) {
  const label = props.children || props.number;
  return <A to={`/buildings/${props.number}`}>{label}</A>;
}
