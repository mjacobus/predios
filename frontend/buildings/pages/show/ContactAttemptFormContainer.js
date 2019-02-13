import React from "react";
import { Grid, Col, Row } from "react-bootstrap";
import { css } from "glamor";
import { Button } from "../../../library";
import { connect } from "react-redux";
import { createContactAttempt, attemptContactOn } from "../../actions";

function mapStateToProps(state) {
  return {
    loading: state.buildingView.creatingContactAttempt,
    building: state.buildingView.building,
    apartment: state.buildingView.contactAttemptOn
  };
}

function mapDispatchToProps(dispatch) {
  return {
    createContactAttempt: createContactAttempt(dispatch),
    attemptContactOn: attemptContactOn(dispatch)
  };
}

const actionsClass = css({
  " button": {
    width: "100px",
    margin: "10px"
  }
});

class ContactAttemptForm extends React.Component {
  constructor(props) {
    super(props);
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
)(ContactAttemptForm);
