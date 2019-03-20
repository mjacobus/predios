import React from "react";
import { Grid, Col, Row } from "react-bootstrap";
import { css } from "glamor";

const style = css({
  margin: "0 0 36px 0"
});
export default function PageBlock({
  visible = true,
  className = style,
  children
}) {
  if (!visible) {
    return <></>;
  }

  return (
    <Grid>
      <Row>
        <Col xs={12}>
          <div className={className}>{children}</div>
        </Col>
      </Row>
    </Grid>
  );
}
