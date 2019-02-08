import React from "react";
import { css } from "glamor";
import { fontSizes, colors, styles } from "../src/components/library/styles";
import { Link } from "react-router-dom";
import { ControlLabel } from "react-bootstrap";

import Icon from "./Icon";
export { Icon };

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
  const background = colors[color] || color || colors.jwBlue;
  const buttonClass = css(styles.button, { background }, className);

  return <button className={buttonClass} {...otherProps} />;
};

export const A = props => {
  const { className, ...otherProps } = props;
  const linkStyle = css(
    {
      color: colors.jwBlue,
      textDecoration: "",
      ":hover": {
        textDecoration: "none"
      }
    },
    className
  );

  if (props.to) {
    return <Link className={linkStyle} {...otherProps} />;
  }

  return <a className={linkStyle} {...otherProps} />;
};

export const CheckIcon = props => {
  const { on, ...otherProps } = props;
  const type = on ? "check" : "times";
  const className = css({
    color: on ? colors.green : colors.red,
    minWidth: "14px"
  });
  return <Icon className={className} type={type} {...otherProps} />;
};

export const DateTime = props => {
  return <span>{props.children}</span>;
};

export const Form = props => {
  const { onSubmit, ...otherProps } = props;
  const preventDefault = e => {
    e.preventDefault();
  };
  let submitHandler = onSubmit || preventDefault;

  return <form {...otherProps} onSubmit={submitHandler} />;
};
