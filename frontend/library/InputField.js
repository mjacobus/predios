import React from "react";
import Input from "./Input";
import Label from "./Label";
import InputErrors from "./InputErrors";

export default function InputField({ label, errors, ...otherProps }) {
  return (
    <>
      <Label>{label}</Label>
      <Input {...otherProps} />
      <InputErrors errors={errors} />
    </>
  );
}
