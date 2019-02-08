import React from "react";
import { css } from "glamor";
import { colors } from "./styles";
import { Link } from "react-router-dom";

export default function A(props) {
  const { className, ...otherProps } = props;
  const linkStyle = css(
    {
      color: colors.jwBlue,
      textDecoration: "",
      ":hover": {
        textDecoration: "none"
      }
    },
    className
  );

  if (props.to) {
    return <Link className={linkStyle} {...otherProps} />;
  }

  return <a className={linkStyle} {...otherProps} />;
}
