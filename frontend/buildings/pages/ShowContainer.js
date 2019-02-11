import React from "react";
import { connect } from "react-redux";
import { Grid, Col, Row } from "react-bootstrap";
import { css } from "glamor";
import { Loader } from "../../library";
import ContactAttemptForm from "./show/ContactAttemptFormContainer";
import Apartment from "./show/Apartment";
import BuildingHeader from "./show/BuildingHeader";
import { ApartmentForm } from "../components";
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
    const { fetching, building } = props;

    const bellClick = this.bellClick;

    if (fetching && !building) {
      return <Loader />;
    }

    let apartments = building.apartments;

    if (props.contactAttemptOn) {
      apartments = [];
    }

    return (
      <div>
        <BuildingHeader building={building} />
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
}

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(ShowContainer);
