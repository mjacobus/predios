import React from "react";
import { css } from "glamor";
import { styles } from "./styles";

export default function({ errors }) {
  if (!!errors == false) {
    return <></>;
  }

  return <small className={styles.redText}> {errors.join(". ")}</small>;
}
