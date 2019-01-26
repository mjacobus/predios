import React from "react";
import { Grid, Col, Row } from "react-bootstrap";
import { css } from "glamor";

const defaultContainer = css({
  maxWidth: "1170px",
  margin: "0 auto",
  marginTop: "51px",
  paddingTop: "15px"
});

export default function DefaultLayout(props) {
  return <div className={defaultContainer}>{props.children}</div>;
}
