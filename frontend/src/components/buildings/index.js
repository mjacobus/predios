import React from "react";
import { css } from "glamor";
import { colors } from "../library/styles";
import { A } from "../library/html";
import Icon from "../library/Icon";

export const ApartmentNumber = props => {
  const className = css({
    width: "35px",
    lineHeight: "35px",
    display: "block",
    color: "white",
    background: colors.jwBlue,
    textAlign: "center",
    verticalAlign: "middle"
  });
  return <span className={className}>{props.children}</span>;
};

export const NumberOfApartments = props => (
  <Icon type="users" text={props.children} />
);

export const Neighborhood = props => {
  return <div>{props.children}</div>;
};

export const BuildingName = props => {
  return <strong>{props.children}</strong>;
};

export const BuildingAddress = props => {
  return <div>{props.children}</div>;
};

export const BuildingLink = props => {
  const label = props.children || props.number;
  return <A href={`/buildings/${props.number}`}>{label}</A>;
};
