import React from "react";
import { css } from "glamor";
import { colors } from "../library/styles";
import { A } from "../library/html";
import Icon from "../library/Icon";

export const BuildingNumber = props => {
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

export const ApartmentNumber = props => {
  return <strong>{props.children}</strong>;
};

export const BuildingAddress = props => {
  return <div>{props.children}</div>;
};

export const BuildingLink = props => {
  const label = props.children || props.number;
  return <A href={`/buildings/${props.number}`}>{label}</A>;
};

// phone, letter, intercom
export const CallOptions = props => {
  const { options } = props;
  let elements = [];
  const className = css({
    float: "right"
  });

  if (options.indexOf("intercom") >= 0) {
    elements.push(<Icon type="building" key="1" />);
  }

  if (options.indexOf("letter") >= 0) {
    elements.push(<Icon type="envelope" key="2" />);
  }

  if (options.indexOf("phone") >= 0) {
    elements.push(<Icon type="phone" key="3" />);
  }

  return <span className={className}>{elements}</span>;
};
