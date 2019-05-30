import React from "react";
import { Grid, Col, Row } from "react-bootstrap";
import { Button, A } from "../../../library";
import {
  BuildingHeader,
  ButtonGroup,
  ContactAttempt,
  PageBlock,
  Label,
  Question
} from "../../../shared/components";
// import { Label } from "../../../library";

export default function Form(props) {
  const { apartment, building, submitHandler } = props;

  return (
    <div>
      <BuildingHeader building={props.building} />
      <PageBlock>
        <Question>
          Quais tentativas de contado deseja remover do apartamento{" "}
          <span>
            <strong>apartamento {apartment.number}</strong>
          </span>
          ?
        </Question>
      </PageBlock>
      <PageBlock>
        {apartment.contact_attempts.map(attempt => (
          <ContactAttempt contactAttempt={attempt} />
        ))}
      </PageBlock>
      <PageBlock>
        <ButtonGroup>
          <Button
            style="red"
            disabled={props.removing}
            onClick={e => submitHandler(apartment, "failed")}
          >
            Remover
          </Button>
          <A buttonStyle="blue" to={`/buildings/${building.number}/apartments`}>
            {" "}
            Cancelar{" "}
          </A>
        </ButtonGroup>
      </PageBlock>
    </div>
  );
}
