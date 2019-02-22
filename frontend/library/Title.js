import React from "react";
import { css } from "glamor";
import { fontSizes } from "./styles";

export default function Title({ level, ...props }) {
  const Component = `h${level}`;
  const { children, className, ...otherProps } = props;
  const classNames = css(
    { fontSize: fontSizes[Component], padding: "0 15px 0 15px" },
    className
  );

  return (
    <Component className={classNames} {...otherProps}>
      {children}
    </Component>
  );
}
