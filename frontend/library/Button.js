import React from "react";
import { css } from "glamor";
import { colors, buttonStyler } from "./styles";

export default function Button({
  style = "jwBrightPurple",
  className,
  ...otherProps
}) {
  const buttonClass = buttonStyler(style, className);

  return <button className={buttonClass} {...otherProps} />;
}
