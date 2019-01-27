import React from "react";
import { css } from "glamor";
import { fontSizes, colors } from "./styles";
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
  const { className, ...otherProps } = props;
  const inputClass = css(
    {
      lineHeight: "32px",
      outline: "none",
      height: "32px",
      padding: "0 4px",
      margin: "none",
      border: "1px solid #ddd"
    },
    className
  );
  return <input className={inputClass} {...otherProps} />;
};

export const Label = props => {
  return <ControlLabel {...props} />;
};

export const Button = props => {
  const { color, className, ...otherProps } = props;
  const background = colors[color];
  const buttonClass = css(
    {
      background,
      border: "none",
      color: "white",
      padding: "0px 12px",
      fontSize: "14px",
      textAlign: "center",
      verticalAlign: "middle",
      lineHeight: "32px",
      height: "32px",
      cursor: "pointer",
      whiteSpace: "nowrap"
    },
    className
  );

  return <button className={buttonClass} {...otherProps} />;
};

export const A = props => {
  const { className, ...otherProps } = props;
  const linkStyle = css({ color: colors.jwBlue }, className);
  return <a className={linkStyle} {...otherProps} />
}
