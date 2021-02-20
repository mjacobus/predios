import React from "react";
import { css } from "glamor";
import { CheckIcon, DateTime, Icon } from "../../library";
import { colors } from "../../library/styles";

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

  const color = contactAttempt.successful ? colors.green : colors.red;

  return (
    <span {...otherProps}>
      <Icon
        type={type}
        data-contact-attempt-type={contactAttempt.type}
        data-contact-attempt-success={contactAttempt.successful}
        color={color}
      >
        <DateTime>{contactAttempt.time}</DateTime>
      </Icon>
    </span>
  );
}
