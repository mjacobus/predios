import React from "react";
import { css } from "glamor";
import { colors } from "../../library/styles";

export default function BuildingNumber(props) {
  const className = css({
    width: "35px",
    lineHeight: "35px",
    display: "block",
    color: "white",
    background: colors.jwDarkPurple,
    textAlign: "center",
    verticalAlign: "middle"
  });
  return <span className={className}>{props.children}</span>;
}
