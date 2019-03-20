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
  margin: "4px 4px 0 0",
  maxWidth: "200px",
  textAlign: "left"
});

const dropDownStyle = css({
  width: "200px"
});

class Apartment extends React.Component {
  constructor(props) {
    super(props);
    this.state = { collapsed: true };
    this.toggleActions = this.toggleActions.bind(this);
  }

  toggleActions(e) {
    const collapsed = !this.state.collapsed;
    this.setState({ collapsed });
  }

  render() {
    const { currentUser, apartment, building } = this.props;
    const { collapsed } = this.state;
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
              <ApartmentNumber onClick={this.toggleActions}>
                {apartment.number}
              </ApartmentNumber>
            </Col>
            <Col xs={6}>
              <div className={contactAttemptsContainer}>
                <ContactAttempts contactAttempts={apartment.contact_attempts} />
              </div>
            </Col>
            <Col xs={2}>
              <Icon
                color="purple"
                type={collapsed ? "plus" : "minus"}
                onClick={this.toggleActions}
              />
            </Col>
          </Row>
          {collapsed || (
            <Row>
              <Col xs={4} />
              <Col xs={8}>
                <DoorBell
                  className={buttonStyle}
                  buttonStyle="green"
                  apartment={apartment}
                  building={building}
                >
                  Tentar contato
                </DoorBell>
                {currentUser.master && (
                  <A
                    className={buttonStyle}
                    buttonStyle="red"
                    to={removeApartmentLink}
                  >
                    <Icon color="white" type="trash-alt">
                      Remover apartamento
                    </Icon>
                  </A>
                )}
              </Col>
            </Row>
          )}
        </Grid>
      </div>
    );
  }
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
