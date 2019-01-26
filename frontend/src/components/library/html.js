import React from "react";
import { css } from "glamor";
import { fontSizes } from "./styles";
import {
  Form,
  FormControl,
  ControlLabel,
  Button as BootstrapButton
} from "react-bootstrap";

export const H1 = props => {
  const { children, className, ...otherProps } = props;
  const classNames = css(
    { fontSize: fontSizes.h1, padding: "0 15px 0 15px" },
    className
  );
  return (
    <h1 className={classNames} {...otherProps}>
      {children}
    </h1>
  );
};

export const Input = props => {
  return <FormControl {...props} />;
};

export const Label = props => {
  return <ControlLabel {...props} />;
};

export const Button = props => {
  return <BootstrapButton {...props} />;
};
