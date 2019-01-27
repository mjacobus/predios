import React from "react";
import Loader from "../library/Loader";
import { Grid, Col, Row } from "react-bootstrap";

import {
  ApartmentNumber,
  CallOptions,
  NumberOfApartments,
  BuildingAddress,
  Neighborhood,
  BuildingLink,
  BuildingName
} from "./index";

export default function BuildingView(props) {
  const { fetching, building } = props;

  if (fetching) {
    return <Loader />;
  }

  return (
    <Grid>
      <Row>
        <Col xs={2}>
          <BuildingLink number={building.number}>
            <ApartmentNumber>{building.number}</ApartmentNumber>
          </BuildingLink>
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
