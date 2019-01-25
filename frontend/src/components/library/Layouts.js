import React from "react";
import { Grid, Col, Row } from "react-bootstrap";
import { css } from "glamor";

const defaultContainer = css({
  maxWidth: "1170px",
  margin: "0 auto"
});

export default function DefaultLayout(props) {
  return (
    <div className={defaultContainer}>
      <Grid fluid={true}>
        <Row>
          <Col sm={12}>{props.children}</Col>
        </Row>
      </Grid>
    </div>
  );
}
