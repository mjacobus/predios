import React from "react";
import { css } from "glamor";

const classNames = {
  left: css({ float: "left" }),
  right: css({ float: "right" })
};

export default function Float({ direction = "left", ...otherProps }) {
  return <div className={classNames[direction]} {...otherProps} />;
}
