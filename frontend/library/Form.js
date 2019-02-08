import React from "react";

export default function Form(props) {
  const { onSubmit, ...otherProps } = props;
  const preventDefault = e => {
    e.preventDefault();
  };
  let submitHandler = onSubmit || preventDefault;

  return <form {...otherProps} onSubmit={submitHandler} />;
}
