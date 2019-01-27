import React from "react";
import Loader from "../library/Loader";
import { colors } from "../library/styles";
import CallOptions from "../library/CallOptions";
import { H1, Input, Label, Button, A } from "../library/html";
import { Grid, Col, Row } from "react-bootstrap";
import { css } from "glamor";

import {
  ApartmentNumber,
  NumberOfApartments,
  BuildingAddress,
  Neighborhood,
  BuildingLink,
  BuildingName
} from "./index";

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
    </div>
  );
};

const Filter = props => {
  const className = css({
    padding: "30px 15px",
    border: "1px solid #ddd",
    margin: "30px 15px",
    background: colors.lightGray
  });

  return (
    <div className={className}>
      <form>
        <Input
          className={css({ width: "70%", marginRight: "15px" })}
          placeholder="Filtro"
          type="text"
          onKeyUp={e => props.filter(e.target.value)}
        />
        <Button type="reset" color={"jwBlue"} onClick={() => props.filter("")}>
          Limpar
        </Button>
      </form>
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
