import React from "react";
import { css } from "glamor";
import { colors } from "../../library/styles";

const defaultStyle = css({
  background: colors.jwBrightPurple,
  color: colors.white,
  padding: "15px"
});

const styles = {
  default: defaultStyle,
  danger: css(defaultStyle, {
    background: colors.red
  })
};

export default function Question({
  children,
  type = "default",
  ...otherProps
}) {
  const className = styles[type];
  return <div className={className}> {children} </div>;
}
