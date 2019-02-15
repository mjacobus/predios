import React from "react";
import { Redirect } from 'react-router-dom';
import { Grid, Col, Row } from "react-bootstrap";
import { css } from "glamor";
import { Button, Loader } from "../../library";
import { connect } from "react-redux";
import { createContactAttempt, attemptContactOn } from "../../buildings/actions";
import ContactAttemptForm from "../components/ContactAttemptFormContainer";
import BuildingHeader from "../../buildings/pages/show/BuildingHeader";
import actions from "../actions";
import { clearRedirect } from "../../shared/actions"

function mapStateToProps(state) {
  return {
    fetching: state.newContactAttempt.fetching,
    building: state.newContactAttempt.building,
    apartment: state.newContactAttempt.apartment,
    creating: state.newContactAttempt.creating,
    redirectTo: state.newContactAttempt.redirectTo,
  };
}

function mapDispatchToProps(dispatch) {
  return {
    createContactAttempt: createContactAttempt(dispatch),
    attemptContactOn: attemptContactOn(dispatch),
    fetchApartmentByBuildingNumber: actions.fetchApartmentByBuildingNumber(dispatch),
    clearRedirect: clearRedirect(dispatch),
  };
}

const actionsClass = css({
  " button": {
    width: "100px",
    margin: "10px"
  }
});

class NewContactAttemptForm extends React.Component {
  constructor(props) {
    super(props);
  }

  componentDidMount() {
    if (this.props.apartment == null) {
      const { buildingNumber, apartmentNumber  } = this.props.match.params
      this.props.fetchApartmentByBuildingNumber({ buildingNumber, apartmentNumber });
    }
  }

  componentWillUnmount() {
    this.props.clearRedirect();
  }

  handleCreateContactAttempt(apartment, outcome) {
    const { building } = this.props;
    let payload = {
      building,
      apartment,
      outcome
    };
    this.props.createContactAttempt(payload);
  }

  cancelContactAttempt() {
    this.props.attemptContactOn(null);
  }

  render() {
    const props = this.props;

    if (props.redirectTo) {
      return <Redirect to={ props.redirectTo } />
    }

    if (props.fetching) {
      return <Loader />
    }

    const { apartment, building } = props;

    return (
      <div>
        <BuildingHeader building={ this.props.building } />
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
                  disabled={this.props.loading}
                  onClick={e =>
                    this.handleCreateContactAttempt(apartment, "contacted")
                  }
                >
                  Sim
                </Button>
                <Button
                  color="red"
                  disabled={this.props.loading}
                  onClick={e =>
                    this.handleCreateContactAttempt(apartment, "failed")
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
                <Button
                  onClick={e => this.cancelContactAttempt()}
                  disabled={this.props.loading}
                >
                  Cancelar
                </Button>
              </div>
            </Col>
          </Row>
        </Grid>
      </div>
    );
  }
}

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(NewContactAttemptForm);
