import React from "react";
import Icon from "./Icon";
import { css } from "glamor";

// phone, letter, intercom
export default function CallOptions(props) {
  const { options } = props;
  let elements = [];
  const className = css({
    float: "right"
  });

  if (options.indexOf("intercom") >= 0) {
    elements.push(<Icon type="building" key="1" />);
  }

  if (options.indexOf("letter") >= 0) {
    elements.push(<Icon type="envelope" key="2" />);
  }

  if (options.indexOf("phone") >= 0) {
    elements.push(<Icon type="phone" key="3" />);
  }

  return <span className={className}>{elements}</span>;
}
