import React from "react";
import { connect } from "react-redux";
import BuildingView from "./BuildingView";
import ApartmentForm from "./ApartmentFormContainer";
import {
  fetchBuildingByNumber,
  attemptContactOn,
  createContactAttempt
} from "../../actions/buildingsActions";

function mapStateToProps(state) {
  return {
    building: state.buildingView.building,
    fetching: state.buildingView.fetching,
    contactAttemptOn: state.buildingView.contactAttemptOn
  };
}

function mapDispatchToProps(dispatch) {
  return {
    createContactAttempt: createContactAttempt(dispatch),
    fetchBuildingByNumber: fetchBuildingByNumber(dispatch),
    attemptContactOn: attemptContactOn(dispatch)
  };
}

class BuildingViewContainer extends React.Component {
  constructor(props) {
    super(props);
    this.state = { contactAttemptOn: null };
    this.bellClick = this.bellClick.bind(this);
    this.cancelContactAttempt = this.cancelContactAttempt.bind(this);
    this.createApartmentHandler = this.createApartmentHandler.bind(this);
    this.handleCreateContactAttempt = this.handleCreateContactAttempt.bind(
      this
    );
  }

  createApartmentHandler() {
    console.log();
  }

  componentDidMount() {
    const { number } = this.props.match.params;
    this.props.fetchBuildingByNumber(number);
  }

  cancelContactAttempt() {
    this.props.attemptContactOn(null);
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

  bellClick(apartment) {
    this.props.attemptContactOn(apartment);
  }

  render() {
    const { fetching, building, reload, ...otherProps } = this.props;

    const apartmentForm = (
      <ApartmentForm
        building={building}
        submitHandler={this.props.createApartmentHandler}
      />
    );

    const bellClick = this.bellClick;
    const handleCreateContactAttempt = this.handleCreateContactAttempt;
    const props = {
      contactAttemptOn: this.props.contactAttemptOn,
      cancelContactAttempt: this.cancelContactAttempt,
      handleCreateContactAttempt,
      bellClick,
      building,
      fetching,
      apartmentForm,
      ...otherProps
    };

    return <BuildingView {...props} />;
  }
}

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(BuildingViewContainer);
