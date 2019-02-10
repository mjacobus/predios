import React from "react";
import { Grid, Col, Row } from "react-bootstrap";
import { css } from "glamor";
import { Button } from "../../../library";

export default function ContactAttemptForm(props) {
  const { apartment } = props;
  const actionsClass = css({
    " button": {
      width: "100px",
      margin: "10px"
    }
  });

  return (
    <div>
      <Grid>
        <Row>
          <Col xs={12}>
            <p>
              Conseguiu falar com o morador do apartamento{" "}
              <strong>{apartment.number}</strong>?
            </p>
          </Col>
        </Row>
        <Row>
          <Col xs={12}>
            <div className={actionsClass}>
              <Button
                color="green"
                onClick={e =>
                  props.handleCreateContactAttempt(apartment, "contacted")
                }
              >
                Sim
              </Button>
              <Button
                color="red"
                onClick={e =>
                  props.handleCreateContactAttempt(apartment, "failed")
                }
              >
                Não
              </Button>
            </div>
          </Col>
        </Row>
        <Row>
          <Col xs={12}>
            <div className={actionsClass}>
              <Button onClick={e => props.cancelContactAttempt()}>
                Cancelar
              </Button>
            </div>
          </Col>
        </Row>
      </Grid>
    </div>
  );
}
