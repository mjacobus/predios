import React from "react";
import { css } from "glamor";
import { colors, styles } from "./styles";

export default function Button(props) {
  const { color, className, ...otherProps } = props;
  const background = colors[color] || color || colors.jwBlue;
  const buttonClass = css(styles.button, { background }, className);

  return <button className={buttonClass} {...otherProps} />;
}
