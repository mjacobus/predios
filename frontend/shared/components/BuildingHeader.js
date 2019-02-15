import React from "react";
import { Grid, Col, Row } from "react-bootstrap";
import {
  BuildingAddress,
  BuildingLink,
  BuildingName,
  BuildingNumber,
  CallOptions,
  Neighborhood,
  NumberOfApartments
} from "./";

export default function BuildingHeader({ building }) {
  return (
    <Grid>
      <Row>
        <Col xs={2}>
          <BuildingNumber>{building.number}</BuildingNumber>
          <NumberOfApartments>
            {building.number_of_apartments}
          </NumberOfApartments>
        </Col>
        <Col xs={8}>
          <BuildingLink number={building.number}>
            <BuildingName>{building.name}</BuildingName>
          </BuildingLink>
          <BuildingLink number={building.number}>
            <BuildingAddress>{building.address}</BuildingAddress>
          </BuildingLink>
          <Neighborhood>{building.neighborhood}</Neighborhood>
        </Col>
        <Col xs={2}>
          <CallOptions options={building.call_options} />
        </Col>
      </Row>
    </Grid>
  );
}
