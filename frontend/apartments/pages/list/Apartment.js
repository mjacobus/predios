import React from "react";
import { Grid, Col, Row } from "react-bootstrap";
import { css } from "glamor";
import {
  ApartmentNumber,
  ContactAttempts,
  DoorBell,
  DropDownOptions
} from "../../../shared/components";

import { A, Icon } from "../../../library";

export default function Apartment({ apartment, building }) {
  const removeApartmentLink = `/buildings/${building.number}/apartments/${
    apartment.number
  }/remove`;
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
              <DropDownOptions>
                <div>
                  <DoorBell apartment={apartment} building={building}>
                    Tentar contato
                  </DoorBell>
                </div>
                <div>
                  <A to={removeApartmentLink}>
                    <Icon type="trash-alt">Remover apartamento</Icon>
                  </A>
                </div>
              </DropDownOptions>
            </div>
            <div>
              <ContactAttempts contactAttempts={apartment.contact_attempts} />
            </div>
          </Col>
        </Row>
      </Grid>
    </div>
  );
}
