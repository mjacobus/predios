import React from "react";
import { css } from "glamor";

export default function Input(props) {
  const { className, ...otherProps } = props;
  const inputClass = css(
    {
      lineHeight: "32px",
      outline: "none",
      height: "32px",
      padding: "0 4px",
      margin: "none",
      border: "1px solid #ddd",
      width: "100%"
    },
    className
  );
  return <input className={inputClass} {...otherProps} />;
}
