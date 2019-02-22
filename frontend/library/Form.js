import React from "react";

export default function Form(props) {
  const { onSubmit, ...otherProps } = props;
  const preventDefault = e => {
    e.preventDefault();
    console.log("Default prevented");
  };
  let submitHandler = onSubmit || preventDefault;

  return <form {...otherProps} onSubmit={submitHandler} />;
}
