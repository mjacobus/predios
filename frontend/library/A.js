import React from "react";
import { css } from "glamor";
import { colors, buttonStyler } from "./styles";
import { Link } from "react-router-dom";

const defaultLinkStyle = css({
  color: colors.fontRegular
});

export default function A({ buttonStyle, ...props }) {
  let linkStyle = defaultLinkStyle;

  if (buttonStyle) {
    linkStyle = buttonStyler(buttonStyle);
  }

  if (props.to) {
    return <Link className={linkStyle} {...props} />;
  }

  return <a className={linkStyle} {...props} />;
}
