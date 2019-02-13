import React from "react";
import { css } from "glamor";

const style = css({
  padding: "10px 0"
});

export default function FormRow(props) {
  const className = css(style, props.className);
  props = Object.assign({}, props, { className });
  return <div {...props} />;
}
