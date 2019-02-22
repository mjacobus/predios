import React from "react";
import { Grid, Col, Row } from "react-bootstrap";
import { css } from "glamor";

const style = css({
  margin: "0 0 36px 0"
});
export default function PageBlock({ visible = true, children }) {
  if (!visible) {
    return <span />;
  }

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
