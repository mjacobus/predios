import React from "react";
import { Grid, Col, Row } from "react-bootstrap";
import { css } from "glamor";
import { Button, Loader, A, H1 } from "../../../library";
import {
  ContactAttempts,
  BuildingHeader,
  DateTimeInput,
  PageBlock,
  ButtonGroup
} from "../../../shared/components";
import { Label } from "../../../library";

export default function Form(props) {
  const {
    apartment,
    building,
    assignAttempt,
    cancelAttempt,
    currentUser
  } = props;
  const dateTimeChangeListener = props.inputListenerFactory("time");

  return (
    <div>
      <BuildingHeader building={props.building} />
      <PageBlock>
        <p>
          Conseguiu falar com o morador do apartamento{" "}
          <strong>{apartment.number}</strong>?
        </p>
      </PageBlock>
      <PageBlock visible={currentUser.master}>
        <Label>Data e hora no formato 2019/12/31 18:32</Label>
        <DateTimeInput onChange={dateTimeChangeListener} />
        <small>Deixe em branco para usar a data e hora atual</small>
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
      <PageBlock>
        <Grid>
          <Row>
            <Col xs={6}>Histórico</Col>
            <Col xs={6}>
              <ContactAttempts contactAttempts={apartment.contact_attempts} />
            </Col>
          </Row>
        </Grid>
      </PageBlock>
    </div>
  );
}
