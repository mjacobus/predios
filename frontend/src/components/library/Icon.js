import React from "react";
import { css } from "glamor";
import { colors } from "./styles";

export default function Icon(props) {
  const type = props.type;
  const style = props.style || "fa";
  const text = props.text || "";

  const iconStyle = css({
    color: colors.jwBlue
  });

  return (
    <span>
      <i className={`${style} fa-${type} ${iconStyle}`} />
      &nbsp;{text}
    </span>
  );
}
