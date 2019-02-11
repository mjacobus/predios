import React from "react";
import { connect } from "react-redux";
import { Grid, Col, Row } from "react-bootstrap";
import { css } from "glamor";
import { Loader } from "../../library";
import ContactAttemptForm from "./show/ContactAttemptFormContainer";
import Apartment from "./show/Apartment";
import {
  ApartmentForm,
  BuildingAddress,
  BuildingLink,
  BuildingName,
  BuildingNumber,
  CallOptions,
  Neighborhood,
  NumberOfApartments
} from "../components";
import { fetchBuildingByNumber, attemptContactOn } from "../actions";

function mapStateToProps(state) {
  return {
    building: state.buildingView.building,
    fetching: state.buildingView.fetching,
    contactAttemptOn: state.buildingView.contactAttemptOn
  };
}

function mapDispatchToProps(dispatch) {
  return {
    attemptContactOn: attemptContactOn(dispatch),
    fetchBuildingByNumber: fetchBuildingByNumber(dispatch)
  };
}

function Show(props) {
  const { fetching, building } = props;

  const bellClick = props.bellClick;

  if (fetching && !building) {
    return <Loader />;
  }

  let apartments = building.apartments;

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
      {props.building.has_all_apartments || <ApartmentForm />}
      <div className={css({ marginTop: "32px" })}>
        {props.contactAttemptOn && <ContactAttemptForm />}
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

class ShowContainer extends React.Component {
  constructor(props) {
    super(props);
    this.state = { contactAttemptOn: null };
    this.bellClick = this.bellClick.bind(this);
  }

  componentDidMount() {
    const { number } = this.props.match.params;
    this.props.fetchBuildingByNumber(number);
  }

  bellClick(apartment) {
    this.props.attemptContactOn(apartment);
  }

  render() {
    const props = this.props;
    return <Show {...props} bellClick={this.bellClick} />;
  }
}

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(ShowContainer);
