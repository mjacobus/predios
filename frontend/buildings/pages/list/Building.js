import React from "react";
import { Grid, Col, Row } from "react-bootstrap";
import { css } from "glamor";
import {
  BuildingNumber,
  NumberOfApartments,
  BuildingAddress,
  Neighborhood,
  BuildingLink,
  CallOptions,
  BuildingName
} from "../../../shared/components";

export default function Building({ building }) {
  const buildingClass = css({
    borderBottom: "1px solid #dddddd",
    padding: "10px 0"
  });

  return (
    <div className={buildingClass}>
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
    </div>
  );
}
