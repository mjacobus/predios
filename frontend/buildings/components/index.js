import React from "react";
import { css } from "glamor";
import { colors } from "../../library/styles";
import { Button, A, CheckIcon, DateTime, Icon } from "../../library";
import { Link } from "react-router";

import BuildingNumber from "./BuildingNumber";
import ApartmentForm from "./ApartmentFormContainer";
import ApartmentNumber from "./ApartmentNumber";
import NumberOfApartments from "./NumberOfApartments";
import Neighborhood from "./Neighborhood";
import BuildingName from "./BuildingName";
import BuildingAddress from "./BuildingAddress";
import BuildingLink from "./BuildingAddress";

export {
  ApartmentForm,
  BuildingNumber,
  ApartmentNumber,
  NumberOfApartments,
  Neighborhood,
  BuildingAddress,
  BuildingLink,
  BuildingName
};

// phone, letter, intercom
export const CallOptions = props => {
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
};

export const ContactAttempt = props => {
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
};

export const DoorBell = props => {
  return (
    <Button color="#ddd" {...props}>
      <Icon css={css({ color: "white" })} type="bell" />
    </Button>
  );
};
