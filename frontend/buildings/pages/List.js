import React from "react";
import { Grid, Col, Row } from "react-bootstrap";
import { css } from "glamor";
import { H1 } from "../../library";
import { Loader } from "../../library";
import Filter from "./list/Filter";
import {
  BuildingNumber,
  NumberOfApartments,
  BuildingAddress,
  Neighborhood,
  BuildingLink,
  CallOptions,
  BuildingName
} from "../components";

const Building = ({ building }) => {
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
};

export default function BuildingsIndex(props) {
  const { filter, buildings, currentUser, fetching } = props;
  return (
    <div>
      <H1>Edifícios</H1>
      {fetching && <Loader />}
      {fetching || <Filter filter={filter} />}
      {fetching ||
        buildings.map((building, i) => (
          <Building building={building} key={i} />
        ))}
    </div>
  );
}
