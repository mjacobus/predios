import React from "react";
import { css } from "glamor";
import { colors } from "../../library/styles";
import { Button, A, CheckIcon, DateTime, Icon } from "../../library";
import { Link } from "react-router";

export const BuildingNumber = props => {
  const className = css({
    width: "35px",
    lineHeight: "35px",
    display: "block",
    color: "white",
    background: colors.jwBlue,
    textAlign: "center",
    verticalAlign: "middle"
  });
  return <span className={className}>{props.children}</span>;
};

const recentlyContacted = () => {
  return true;
};

export const ApartmentNumber = props => {
  const { contactAttempts, children, otherProps } = props;
  const className = css({
    width: "35px",
    lineHeight: "35px",
    display: "block",
    color: "white",
    background: colors.jwBlue,
    textAlign: "center",
    verticalAlign: "middle"
  });
  return (
    <span className={className} {...otherProps}>
      {children}
    </span>
  );
};

export const NumberOfApartments = props => (
  <Icon type="users">{props.children}</Icon>
);

export const Neighborhood = props => {
  return <div>{props.children}</div>;
};

export const BuildingName = props => {
  return <strong>{props.children}</strong>;
};

export const BuildingAddress = props => {
  return <div>{props.children}</div>;
};

export const BuildingLink = props => {
  const label = props.children || props.number;
  return <A to={`/buildings/${props.number}`}>{label}</A>;
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
