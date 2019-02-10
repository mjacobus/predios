import React from "react";
import { css } from "glamor";
import { H1, Input, Button, Form } from "../../../library";
import { colors, styles } from "../../../library/styles";

export default function Filter(props) {
  return (
    <div className={styles.formContainer}>
      <Form>
        <Input
          className={css({ width: "70%", marginRight: "15px" })}
          placeholder="Filtro"
          type="text"
          onKeyUp={e => props.filter(e.target.value)}
        />
        <Button type="reset" color={"jwBlue"} onClick={() => props.filter("")}>
          Limpar
        </Button>
      </Form>
    </div>
  );
}
