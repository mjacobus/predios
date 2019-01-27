import React from "react";
import Loader from "../library/Loader";
import { Grid, Col, Row } from "react-bootstrap";
import { css } from "glamor";

import {
  BuildingNumber,
  CallOptions,
  NumberOfApartments,
  BuildingAddress,
  Neighborhood,
  BuildingLink,
  ApartmentNumber,
  BuildingName
} from "./index";

const Apartment = props => {
  const { apartment } = props;
  const className = css({
    padding: "15px 0",
    margin: "10px 0",
    borderBottom: "1px solid #ddd"
  });

  return (
    <div className={className}>
      <Grid>
        <Row>
          <Col xs={2}>
            <ApartmentNumber>{apartment.number}</ApartmentNumber>
          </Col>
          <Col xs={6} />
          <Col xs={4} />
        </Row>
      </Grid>
    </div>
  );
};

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
      {building.apartments.map(a => (
        <Apartment apartment={a} key={a.uuid} />
      ))}
    </div>
  );
}
