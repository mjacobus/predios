import React from "react";
import { A } from "../../library";

export default function BuildingLink({ label, children, number, type }) {
  const content = children || number;

  let link = `/buildings/${number}/apartments`;

  if (type == "edit") {
    link = `/buildings/${number}/edit`;
  }

  return <A to={link}>{content}</A>;
}
