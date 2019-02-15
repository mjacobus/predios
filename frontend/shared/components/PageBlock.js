import React from "react";
import { Grid, Col, Row } from "react-bootstrap";
import { css } from "glamor";

const style = css({
  margin: "18px 0"
});
export default function PageBlock({ children }) {
  return (
    <Grid>
      <Row>
        <Col xs={12}>
          <div className={style}>{children}</div>
        </Col>
      </Row>
    </Grid>
  );
}
