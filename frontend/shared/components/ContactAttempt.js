import React from "react";
import { css } from "glamor";
import { CheckIcon, DateTime, Icon } from "../../library";
import { colors } from "../../styles";

const successClass = css({
  color: colors.green
});

const failureClass = css({
  color: colors.red
});

export default function ContactAttempt(props) {
  const { contactAttempt, otherProps } = props;

  if (!contactAttempt) {
    return <span />;
  }

  let type = null;

  if (contactAttempt.type == "intercom") {
    type = "building";
  }

  if (contactAttempt.type == "phone") {
    type = "phone";
  }

  if (contactAttempt.type == "letter") {
    type = "envelope";
  }

  const className = contactAttempt.successful ? successClass : failureClass;

  return (
    <div {...otherProps}>
      <Icon type={type} className={className}>
        <DateTime>{contactAttempt.time}</DateTime>
      </Icon>
    </div>
  );
}
