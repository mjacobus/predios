import React from "react";
import { css } from "glamor";
import { Button, Icon } from "../../library";

export default function DoorBell(props) {
  return (
    <Button color="#ddd" {...props}>
      <Icon css={css({ color: "white" })} type="bell" />
    </Button>
  );
}
