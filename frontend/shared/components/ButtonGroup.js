import React from "react";
import { css } from "glamor";

const style = css({
  marginLeft: "10px"
});

export default function ButtonGroup({ children }) {
  const length = children.length;
  const margin = 6;
  const width = (100 - margin * length) / length;
  const marginLeft = margin + "%";

  const style = css({
    " a, button ": {
      width: width + "%",
      marginLeft
    },
    " a:first-child, button:first-child": {
      marginLeft: 0
    }
  });

  return <div className={style}>{children}</div>;
}
