import React from "react";
import Loader from "../library/Loader";
import { Grid, Col, Row } from "react-bootstrap";

import {
  BuildingNumber,
  CallOptions,
  NumberOfApartments,
  BuildingAddress,
  Neighborhood,
  BuildingLink,
  BuildingName
} from "./index";

const Apartment = (props) => {
  const { apartment } = props;

  return <Grid>
        <Row>
          <Col xs={2}>
            {apartment.number}
          </Col>
          <Col xs={6}>
          </Col>
          <Col xs={4}>
          </Col>
        </Row>
    </Grid>
      
}

export default function BuildingView(props) {
  const { fetching, building } = props;

  if (fetching) {
    return <Loader />;
  }

  return (
    <div>
      <Grid>
        <Row>
          <Col xs={2}>
            <BuildingLink number={building.number}>
              <BuildingNumber>{building.number}</BuildingNumber>
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
      {building.apartments.map(a => (
        <Apartment apartment={a} key={a.uuid} />
      ))}
    </div>
  );
}
