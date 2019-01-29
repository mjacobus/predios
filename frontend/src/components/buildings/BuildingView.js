import React from "react";
import Loader from "../library/Loader";
import { Grid, Col, Row } from "react-bootstrap";
import { css } from "glamor";
import { A } from "../library/html";

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
            <DoorBell
              onClick={() => props.bellClick(apartment.uuid)}
              className={css({ float: "right" })}
            />
          </Col>
        </Row>
      </Grid>
    </div>
  );
};

export default class BuildingView extends React.Component {
  constructor(props) {
    super(props);
    this.bellClick = this.bellClick.bind(this);
    this.cancelContactAttempt = this.cancelContactAttempt.bind(this);
    this.createContactAttempt = this.createContactAttempt.bind(this);
    this.state = { contactAttemptOn: null };
  }

  bellClick(apartment) {
    this.setState({ contactAttemptOn: apartment });
  }

  cancelContactAttempt() {
    this.setState({ contactAttemptOn: null });
  }

  createContactAttempt(apartment, outcome) {
    const { building } = this.props;
    let payload = {
      building,
      apartment,
      outcome
    };
    this.props.createContactAttempt(payload);
  }

  render() {
    const { fetching, building } = this.props;
    const bellClick = this.bellClick;

    if (fetching) {
      return <Loader />;
    }

    let apartments = building.apartments;
    const apartment = this.state.contactAttemptOn;
    const cancelContactAttempt = this.cancelContactAttempt;
    const createContactAttempt = this.createContactAttempt;
    const contactAttemptProps = {
      apartment,
      cancelContactAttempt,
      createContactAttempt
    };

    if (this.state.contactAttemptOn) {
      apartments = [];
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
          {this.state.contactAttemptOn && (
            <ContactAttemptView {...contactAttemptProps} />
          )}
          {apartments.map(a => (
            <Apartment
              apartment={a}
              key={a.uuid}
              bellClick={() => bellClick(a)}
            />
          ))}
        </div>
      </div>
    );
  }
}

const ContactAttemptView = props => {
  const { apartment } = props;

  return (
    <div>
      <Grid>
        <Row>
          <Col xs={12}>
            <p>
              Conseguiu falar com o morador do apartamento{" "}
              <strong>{apartment.number}</strong>?
            </p>
          </Col>
        </Row>
        <Row>
          <Col xs={12}>
            <A onClick={e => props.cancelContactAttempt()}>Cancelar</A>
            <A onClick={e => props.createContactAttempt(apartment, "failed")}>
              Não
            </A>
            <A
              onClick={e => props.createContactAttempt(apartment, "contacted")}
            >
              Sim
            </A>
          </Col>
        </Row>
      </Grid>
    </div>
  );
};
