import React from "react";
import { css } from "glamor";
import { colors } from "./styles";
import { Icon } from "./";

export default function CheckIcon(props) {
  const { on, ...otherProps } = props;
  const type = on ? "check" : "times";
  const className = css({
    color: on ? colors.green : colors.red,
    minWidth: "14px"
  });
  return <Icon className={className} type={type} {...otherProps} />;
}
