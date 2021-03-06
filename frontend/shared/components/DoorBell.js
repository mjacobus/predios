import React from "react";
import { css } from "glamor";
import { A, Button, Icon } from "../../library";

export default function DoorBell({
  apartment,
  building,
  children,
  ...otherProps
}) {
  const link = `/buildings/${building.number}/apartments/${
    apartment.number
  }/contact-attempts/new`;

  return (
    <A to={link} {...otherProps}>
      <Icon type="bell" color="white">
        {children}
      </Icon>
    </A>
  );
}
