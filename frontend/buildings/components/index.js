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
import CallOptions from "./CallOptions";
import ContactAttempt from "./ContactAttempt";

export {
  ApartmentForm,
  BuildingNumber,
  ApartmentNumber,
  NumberOfApartments,
  Neighborhood,
  BuildingAddress,
  BuildingLink,
  CallOptions,
  ContactAttempt,
  BuildingName
};

export const DoorBell = props => {
  return (
    <Button color="#ddd" {...props}>
      <Icon css={css({ color: "white" })} type="bell" />
    </Button>
  );
};
