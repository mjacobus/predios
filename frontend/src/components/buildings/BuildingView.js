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
  ContactAttempt,
  DoorBell,
  BuildingName
} from "./index";

class ContactAttempts extends React.Component {
  constructor(props) {
    super(props);
    this.state = { open: false };
    this.toggle = this.toggle.bind(this);
  }

  toggle() {
    console.log("toggling");
    this.setState({ open: !this.state.open });
  }

  render() {
    const attempts = this.props.contactAttempts.slice().reverse();

    if (attempts.length == 0) {
      return <span />;
    }

    const first = attempts.shift();

    let firstEntry = <ContactAttempt contactAttempt={first} />;

    if (attempts.length > 0) {
      firstEntry = <a onClick={this.toggle}>{firstEntry}</a>;
    }

    return (
      <div>
        {firstEntry}
        {this.state.open &&
          attempts.map((attempt, key) => (
            <ContactAttempt contactAttempt={attempt} key={key} />
          ))}
      </div>
    );
  }
}

const Apartment = props => {
  const { apartment } = props;
  const className = css({
    padding: "15px 0",
    borderBottom: "1px solid #ddd"
  });

  return (
    <div className={className}>
      <Grid>
        <Row>
          <Col xs={2}>
            <ApartmentNumber>{apartment.number}</ApartmentNumber>
          </Col>
          <Col xs={6}>
            <ContactAttempts contactAttempts={apartment.contact_attempts} />
          </Col>
          <Col xs={4}>
            <DoorBell />
          </Col>
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
      <div className={css({ marginTop: "32px" })}>
        {building.apartments.map(a => (
          <Apartment apartment={a} key={a.uuid} />
        ))}
      </div>
    </div>
  );
}
