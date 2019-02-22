import React from "react";
import { connect } from "react-redux";
import { css } from "glamor";
import { Grid, Col, Row } from "react-bootstrap";
import BuildingAddress from "./BuildingAddress";
import BuildingLink from "./BuildingLink";
import BuildingName from "./BuildingName";
import BuildingNumber from "./BuildingNumber";
import CallOptions from "./CallOptions";
import Neighborhood from "./Neighborhood";
import NumberOfApartments from "./NumberOfApartments";
import Float from "./Float";

function BuildingHeader({ building, currentUser }) {
  const linkType = currentUser.master ? "edit" : "none";
  return (
    <Grid>
      <Row>
        <Col xs={8}>
          <BuildingLink type={linkType} number={building.number}>
            <BuildingName>{building.name}</BuildingName>
          </BuildingLink>
          <BuildingLink type={linkType} number={building.number}>
            <BuildingAddress>{building.address}</BuildingAddress>
          </BuildingLink>
          <Neighborhood>{building.neighborhood}</Neighborhood>
        </Col>
        <Col xs={2}>
          <CallOptions options={building.call_options} />
        </Col>
        <Col xs={2}>
          <Float direction="right">
            <BuildingNumber>{building.number}</BuildingNumber>
            <NumberOfApartments>
              {building.number_of_apartments}
            </NumberOfApartments>
          </Float>
        </Col>
      </Row>
    </Grid>
  );
}

function mapStateToProps(state) {
  return {
    currentUser: state.currentUser
  };
}

export default connect(mapStateToProps)(BuildingHeader);
