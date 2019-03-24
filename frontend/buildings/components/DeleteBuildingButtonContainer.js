import React from "react";
import { connect } from "react-redux";
import { Redirect } from "react-router-dom";
import actions from "../actions";
import { clearRedirect } from "../../shared/actions";
import { Button } from "../../library";
import { ButtonGroup, PageBlock, Question } from "../../shared/components";

const DEFAULT_STATE = {
  collapsed: true
};

class DeleteBuildingButton extends React.Component {
  constructor(props) {
    super(props);
    this.removeApartment = this.removeApartment.bind(this);
    this.toggle = this.toggle.bind(this);
    this.state = DEFAULT_STATE;
  }

  removeApartment(e) {
    e.preventDefault();
    const { building } = this.props;
    this.props.deleteBuilding(building);
  }

  toggle(e) {
    e.preventDefault();
    const collapsed = !this.state.collapsed;
    this.setState({ collapsed });
  }

  componentWillUnmount() {
    this.props.clearRedirect();
  }

  render() {
    const collapsed = this.state.collapsed;
    const { deleting, redirectTo } = this.props;

    if (redirectTo) {
      return <Redirect to={redirectTo} />;
    }
    return (
      <>
        <hr />
        {collapsed || (
          <>
            <PageBlock>
              <Question type="danger">
                Tem certeza que deseja excluir este prédio?
              </Question>
            </PageBlock>
            <PageBlock>
              <small>Esta ação não pode ser desfeita</small>
            </PageBlock>
          </>
        )}
        <PageBlock>
          {collapsed && <Button onClick={this.toggle}>Excluir Prédio</Button>}

          {collapsed || (
            <>
              <ButtonGroup>
                <Button disabled={deleting} onClick={this.toggle}>
                  Cancelar
                </Button>
                <Button
                  disabled={deleting}
                  style="red"
                  onClick={this.removeApartment}
                >
                  Sim
                </Button>
              </ButtonGroup>
            </>
          )}
        </PageBlock>
      </>
    );
  }
}

function mapStateToProps(state) {
  return {
    redirectTo: state.removeBuilding.redirectTo,
    building: state.removeBuilding.building,
    deleting: state.removeBuilding.deleting
  };
}

function mapDispatchToProps(dispatch) {
  return {
    clearRedirect: clearRedirect(dispatch),
    deleteBuilding: actions.deleteBuilding(dispatch)
  };
}

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(DeleteBuildingButton);
