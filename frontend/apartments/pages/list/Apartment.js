import React from "react";
import { Grid, Col, Row } from "react-bootstrap";
import { css } from "glamor";
import {
  ApartmentNumber,
  ContactAttempts,
  DoorBell
} from "../../../shared/components";

export default function Apartment({ apartment, building }) {
  const className = css({
    padding: "15px 0",
    borderBottom: "1px solid #ddd"
  });

  return (
    <div className={className}>
      <Grid>
        <Row>
          <Col xs={2}>
            <ApartmentNumber>{apartment.number}</ApartmentNumber>
          </Col>
          <Col xs={6}>
            <ContactAttempts contactAttempts={apartment.contact_attempts} />
          </Col>
          <Col xs={4}>
            <DoorBell
              apartment={apartment}
              building={building}
              className={css({ float: "right" })}
            />
          </Col>
        </Row>
      </Grid>
    </div>
  );
}
