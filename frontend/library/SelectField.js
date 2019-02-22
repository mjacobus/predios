import React from "react";
import { css } from "glamor";
import Label from "./Label";
import { styles } from "./styles";

const Option = ({ value, description }) => {
  return <option value={value}>{description} </option>;
};

const SelectInput = ({ options, ...selectProps }) => {
  return (
    <select {...selectProps} className={styles.select}>
      {options.map((o, k) => (
        <Option {...o} className={styles.select} key={k} />
      ))}
    </select>
  );
};

export default class SelectField extends React.Component {
  render() {
    const { label, ...selectProps } = this.props;
    return (
      <>
        <Label>{label}</Label>
        <SelectInput {...selectProps} />
      </>
    );
  }
}
