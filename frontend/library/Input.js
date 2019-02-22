import React from "react";
import { css } from "glamor";
import { styles } from "./styles";

export default function Input(props) {
  const { className, ...otherProps } = props;
  const inputClass = css(styles.input, className);
  return <input className={inputClass} {...otherProps} />;
}
