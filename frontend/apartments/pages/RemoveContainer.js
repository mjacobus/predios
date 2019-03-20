import React from "react";
import { Redirect } from "react-router-dom";
import { connect } from "react-redux";
import { Loader } from "../../library";
import actions from "../actions";
import { clearRedirect } from "../../shared/actions";
import {
  Question,
  BuildingHeader,
  PageBlock,
  ButtonGroup
} from "../../shared/components";
import { A, Button } from "../../library";
import Apartments from "./list/Apartments";

class RemoveApartmentContainer extends React.Component {
  constructor(props) {
    super(props);
    this.remove = this.remove.bind(this);
  }

  componentDidMount() {
    this.fetchApartment();
  }

  componentWillUnmount() {
    this.props.clearRedirect();
  }

  remove(e) {
    e.preventDefault();
    const { building, apartment } = this.props;
    this.props.removeApartment({ building, apartment });
  }

  fetchApartment() {
    const { buildingNumber, apartmentNumber } = this.props.match.params;
    this.props.fetchApartment({ buildingNumber, apartmentNumber });
  }

  render() {
    const {
      apartment,
      building,
      deleting,
      error,
      fetching,
      redirectTo
    } = this.props;

    if (error) {
      return <p>{error}</p>;
    }

    if (redirectTo) {
      return <Redirect to={redirectTo} />;
    }

    if (fetching) {
      return <Loader />;
    }

    const cancelLink = `/buildings/${building.number}/apartments`;

    return (
      <>
        <BuildingHeader building={building} />
        <PageBlock>
          <Question type="danger">
            Tem certeza de que quer remover o apartamento{" "}
            <strong>{apartment.number}</strong>?
          </Question>
          <p>
            <small>Esta ação não pode ser desfeita</small>
          </p>
        </PageBlock>
        <PageBlock>
          <ButtonGroup>
            <A buttonStyle="purple" to={cancelLink}>
              Cancelar
            </A>
            <Button onClick={this.remove} disabled={deleting}>
              Remover
            </Button>
          </ButtonGroup>
        </PageBlock>
      </>
    );
  }
}

function mapStateToProps(state) {
  return {
    apartment: state.removeApartment.apartment,
    building: state.removeApartment.building,
    deleting: state.removeApartment.deleting,
    error: state.removeApartment.error,
    fetching: state.removeApartment.fetching,
    redirectTo: state.removeApartment.redirectTo
  };
}

function mapDispatchToProps(dispatch) {
  return {
    clearRedirect: clearRedirect(dispatch),
    fetchApartment: actions.fetchApartment(dispatch),
    removeApartment: actions.removeApartment(dispatch)
  };
}

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(RemoveApartmentContainer);
