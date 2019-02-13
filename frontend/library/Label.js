import React from "react";
import { css } from "glamor";

const labelClass = css({
  marginRight: "10px",
  fontWeight: "normal"
});

export default function Label(props) {
  const className = css(labelClass, props.className);
  props = Object.assign({}, props, { className });
  return <label {...props} />;
}
