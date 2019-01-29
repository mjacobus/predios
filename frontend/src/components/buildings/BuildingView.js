import React from "react";
import Loader from "../library/Loader";
import { Grid, Col, Row } from "react-bootstrap";
import { css } from "glamor";
import { A, Button } from "../library/html";

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

export default function BuildingView(props) {
  const {
    fetching,
    building,
    cancelContactAttempt,
    createContactAttempt
  } = props;

  const bellClick = props.bellClick;

  if (fetching) {
    return <Loader />;
  }

  let apartments = building.apartments;
  const apartment = props.contactAttemptOn;

  const { handleCreateContactAttempt } = props;

  const contactAttemptProps = {
    apartment,
    handleCreateContactAttempt,
    cancelContactAttempt
  };

  if (props.contactAttemptOn) {
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
        {props.contactAttemptOn && (
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

const ContactAttemptView = props => {
  const { apartment } = props;
  const actionsClass = css({
    " button": {
      width: "100px",
      margin: "10px"
    }
  });

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
            <div className={actionsClass}>
              <Button
                color="green"
                onClick={e =>
                  props.handleCreateContactAttempt(apartment, "contacted")
                }
              >
                Sim
              </Button>
              <Button
                color="red"
                onClick={e =>
                  props.handleCreateContactAttempt(apartment, "failed")
                }
              >
                Não
              </Button>
            </div>
          </Col>
        </Row>
        <Row>
          <Col xs={12}>
            <div className={actionsClass}>
              <Button onClick={e => props.cancelContactAttempt()}>
                Cancelar
              </Button>
            </div>
          </Col>
        </Row>
      </Grid>
    </div>
  );
};
