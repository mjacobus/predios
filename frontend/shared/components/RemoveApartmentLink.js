import React from "react";

import { css } from "glamor";
import { A, Button, Icon } from "../../library";

const bellClass = css({ color: "white" });

export default function DoorBell({
  apartment,
  building,
  children = Excluir,
  ...otherProps
}) {
  const link = `/buildings/${building.number}/apartments/${
    apartment.number
  }/contact-attempts/new`;

  return (
    <A to={link} {...otherProps}>
      <Icon css={bellClass} type="bell">
        {children}
      </Icon>
    </A>
  );
}
