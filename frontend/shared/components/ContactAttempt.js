import React from "react";
import { CheckIcon, DateTime } from "../../library";

export default function ContactAttempt(props) {
  const { contactAttempt, otherProps } = props;

  if (!contactAttempt) {
    return <span />;
  }

  return (
    <div {...otherProps}>
      <CheckIcon on={contactAttempt.successful}>
        <DateTime>{contactAttempt.time}</DateTime>
      </CheckIcon>
    </div>
  );
}
