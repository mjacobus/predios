import React from "react";
import { css } from "glamor";
import { colors } from "../src/components/library/styles";

export default function Icon(props) {
  const type = props.type;
  const style = props.style || "fa";
  const text = props.text || "";
  const className = props.className;
  const children = props.children;

  const iconStyle = css(
    {
      color: colors.jwBlue
    },
    className
  );

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
