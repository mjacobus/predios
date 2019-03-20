import React from "react";
import { css } from "glamor";
import { colors, buttonStyler } from "./styles";
import { Link } from "react-router-dom";

const defaultLinkStyle = css({
  color: colors.fontRegular
});

export default function A({ buttonStyle, className, ...props }) {
  let linkStyle = defaultLinkStyle;

  if (buttonStyle) {
    linkStyle = buttonStyler(buttonStyle);
  }

  linkStyle = css(linkStyle, className);

  if (props.to) {
    return <Link className={linkStyle} {...props} />;
  }

  return <a className={linkStyle} {...props} />;
}
