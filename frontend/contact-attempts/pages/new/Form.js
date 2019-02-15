import React from "react";

import { Grid, Col, Row } from "react-bootstrap";
import { Button, Loader, A } from "../../../library";
import {
  BuildingHeader,
  PageBlock,
  ButtonGroup
} from "../../../shared/components";
import { css } from "glamor";

const actionsClass = css({
  " button": {
    width: "100px",
    margin: "10px"
  }
});

export default function Form(props) {
  const { apartment, building, assignAttempt, cancelAttempt } = props;

  return (
    <div>
      <BuildingHeader building={props.building} />
      <PageBlock>
        <p>
          Conseguiu falar com o morador do apartamento{" "}
          <strong>{apartment.number}</strong>?
        </p>
      </PageBlock>
      <PageBlock>
        <ButtonGroup>
          <Button
            style="green"
            disabled={props.creating}
            onClick={e => assignAttempt(apartment, "contacted")}
          >
            Sim
          </Button>
          <Button
            style="red"
            disabled={props.creating}
            onClick={e => assignAttempt(apartment, "failed")}
          >
            Não
          </Button>
          <A buttonStyle="blue" to={`/buildings/${building.number}/apartments`}>
            {" "}
            Não tentei{" "}
          </A>
        </ButtonGroup>
      </PageBlock>
    </div>
  );
}
