import React from "react";
import { css } from "glamor";
import { fontSizes, colors, styles } from "./styles";

import Icon from "./Icon";
export { Icon };

import DefaultLayout from "./DefaultLayout";
export { DefaultLayout };

import Loader from "./Loader";
import H1 from "./H1";
import Label from "./Label";
import A from "./A";
import Input from "./Input";
import Button from "./Button";

export { Loader, H1, Label, Input, A, Button };

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
