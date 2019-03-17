import React from "react";
import { Grid, Col, Row } from "react-bootstrap";
import { css } from "glamor";
import {
  ApartmentNumber,
  ContactAttempts,
  DoorBell,
  DropDownOptions
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
          <Col xs={4}>
            <ApartmentNumber>{apartment.number}</ApartmentNumber>
          </Col>
          <Col xs={8}>
            <div>
              <ContactAttempts contactAttempts={apartment.contact_attempts} />
            </div>
            <div>
              <DropDownOptions>
                <DoorBell apartment={apartment} building={building}>
                  Tentar Contato
                </DoorBell>
              </DropDownOptions>
            </div>
          </Col>
        </Row>
      </Grid>
    </div>
  );
}
