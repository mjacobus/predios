import React from "react";
import { css } from "glamor";
import { colors } from "../../library/styles";

export default function ApartmentNumber(props) {
  const { contactAttempts, children, otherProps } = props;
  const className = css({
    width: "35px",
    lineHeight: "35px",
    display: "block",
    color: "white",
    background: colors.jwSoftPurple,
    textAlign: "center",
    verticalAlign: "middle"
  });
  return (
    <span className={className} {...otherProps}>
      {children}
    </span>
  );
}
