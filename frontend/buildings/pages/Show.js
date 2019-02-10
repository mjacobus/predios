import React from "react";
import { Grid, Col, Row } from "react-bootstrap";
import { css } from "glamor";
import Apartment from "./show/Apartment";
import ContactAttemptForm from "./show/ContactAttemptForm";
import { Loader } from "../../library";

import {
  BuildingNumber,
  CallOptions,
  NumberOfApartments,
  BuildingAddress,
  Neighborhood,
  BuildingLink,
  BuildingName
} from "../components";

export default function BuildingView(props) {
  const {
    fetching,
    building,
    cancelContactAttempt,
    createContactAttempt
  } = props;

  const bellClick = props.bellClick;

  if (fetching && !building) {
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
      {props.building.has_all_apartments || props.apartmentForm}
      <div className={css({ marginTop: "32px" })}>
        {props.contactAttemptOn && (
          <ContactAttemptForm {...contactAttemptProps} />
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
