import React from "react";
import { css } from "glamor";
import { colors } from "./styles";

export default function Icon({
  type,
  style = "fa",
  text = "",
  children,
  className,
  color = colors.jwSoftPurple
}) {
  const iconStyle = css({ color }, className);

  const spanClass = css({
    marginLeft: children ? "4px" : ""
  });

  return (
    <span>
      <i className={`${style} fa-${type} ${iconStyle}`} />
      <span className={spanClass}>{children}</span>
    </span>
  );
}
