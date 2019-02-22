import React from "react";
import Input from "./Input";
import Label from "./Label";

export default function InputField({ label, ...otherProps }) {
  return (
    <>
      <Label>{label}</Label>
      <Input {...otherProps} />
    </>
  );
}
