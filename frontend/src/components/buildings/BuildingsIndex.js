import React from "react";
import Loader from "../library/Loader";
import { colors } from "../library/styles";
import Icon from "../library/Icon";
import { H1 } from "../library/html";
import { Grid, Col, Row } from "react-bootstrap";
import { css } from "glamor";

const NumberOfApartments = props => <Icon type="users" text={props.number} />;

const ApartmentNumber = props => {
  const className = css({
    width: "35px",
    lineHeight: "35px",
    display: "block",
    color: "white",
    background: colors.jwBlue,
    textAlign: "center",
    verticalAlign: "middle"
  });
  return <span className={className}>{props.number}</span>;
};

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
            <ApartmentNumber number={building.number} />
            <NumberOfApartments number={building.number_of_apartments} />
          </Col>
          <Col xs={8}>
            <div>{building.address}</div>
            <div>{building.neighborhood}</div>
            <div>{building.name}</div>
          </Col>
          <Col xs={2}>Modalidades</Col>
        </Row>
      </Grid>
    </div>
  );
};

export default function BuildingsIndex(props) {
  const { buildings, currentUser, fetching } = props;
  return (
    <div>
      <H1>Edifícios</H1>
      {fetching && <Loader />}
      {fetching ||
        buildings.map((building, i) => (
          <Building building={building} key={i} />
        ))}
    </div>
  );
}
