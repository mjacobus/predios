import React from "react";
import { Grid, Row, Col, Alert } from "react-bootstrap";

export default function Loader() {
  return (
    <Grid>
      <Row>
        <Col xs={12}>
          <Alert bsStyle="warning">
            <strong>Carregando...</strong>
          </Alert>
        </Col>
      </Row>
    </Grid>
  );
}
