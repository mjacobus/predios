import React from "react";
import { css } from "glamor";
import { fontSizes } from "./styles";

export const H1 = props => {
  const { children, className, ...otherProps } = props;
  const classNames = css(
    { fontSize: fontSizes.h1, padding: "0 15px 0 15px" },
    className
  );
  return (
    <h1 className={classNames} {...otherProps}>
      {children}
    </h1>
  );
};
