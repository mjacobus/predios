import React from "react";
import { connect } from "react-redux";
import { Grid, Col, Row } from "react-bootstrap";
import { css } from "glamor";
import {
  ApartmentNumber,
  ContactAttempts,
  DoorBell,
  DropDownOptions
} from "../../../shared/components";

import { A, Icon } from "../../../library";

const contactAttemptsContainer = css({ width: "100%", float: "left" });

const buttonStyle = css({
  width: "100%",
  margin: "4px 0",
  maxWidth: "200px",
  textAlign: "left"
});

const dropDownStyle = css({
  width: "200px"
});

function Apartment({ currentUser, apartment, building }) {
  const removeApartmentLink = `/buildings/${building.number}/apartments/${
    apartment.number
  }/remove`;
  const className = css({
    padding: "15px 0",
    borderBottom: "1px solid #ddd"
  });

  return (
    <div className={className}>
      <Grid>
        <Row>
          <Col xs={4}>
            <ApartmentNumber>{apartment.number}</ApartmentNumber>
          </Col>
          <Col xs={8}>
            <div className={contactAttemptsContainer}>
              <ContactAttempts contactAttempts={apartment.contact_attempts} />
            </div>
          </Col>
        </Row>
        <Row>
          <Col xs={12}>
            <DropDownOptions>
              <DoorBell
                className={buttonStyle}
                buttonStyle="purple"
                apartment={apartment}
                building={building}
              >
                Tentar contato
              </DoorBell>
              {currentUser.master && (
                <A
                  className={buttonStyle}
                  buttonStyle="purple"
                  to={removeApartmentLink}
                >
                  <Icon color="white" type="trash-alt">
                    Remover apartamento
                  </Icon>
                </A>
              )}
            </DropDownOptions>
          </Col>
        </Row>
      </Grid>
    </div>
  );
}

function mapStateToProps(state) {
  return {
    currentUser: state.currentUser
  };
}

function mapDispatchToProps(dispatch) {
  return {};
}

export const ApartmentContainer = connect(
  mapStateToProps,
  mapDispatchToProps
)(Apartment);
export default ApartmentContainer;
