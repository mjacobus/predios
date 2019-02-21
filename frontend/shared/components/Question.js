import React from "react";
import { css } from "glamor";
import { colors } from "../../library/styles";

const className = css({
  background: colors.jwBrightPurple,
  color: colors.white,
  padding: "15px"
});

export default function Question({ children, ...otherProps }) {
  return <div className={className}> {children} </div>;
}
