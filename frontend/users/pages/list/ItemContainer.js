import React from "react";
import { connect } from "react-redux";
import actions from "../../actions";
import { Grid, Col, Row, Title, Toggler } from "../../../library";

const nullToggler = () => {
  console.log("Action forbidden");
};

const UserListItem = ({
  user,
  currentUser,
  toggleEnabledFlag,
  toggleMasterFlag
}) => {
  return (
    <>
      <Grid>
        <Row>
          <Col xs={2}>
            <img src={user.avatar_url.replace("{SIZE}", 40)} />
          </Col>
          <Col xs={8}>
            <div> {user.name}</div>
            <div> {user.email}</div>
          </Col>
        </Row>
        <Row>
          <Col xs={2} />
          <Col xs={10}>
            <div>
              <Toggler
                entity={user}
                toggler={
                  currentUser.id == user.id ? nullToggler : toggleEnabledFlag
                }
                label="Enabled"
                locked={currentUser.id == user.id}
                on={user.enabled}
              />
            </div>
            <div>
              <Toggler
                entity={user}
                toggler={
                  currentUser.id == user.id ? nullToggler : toggleMasterFlag
                }
                label="Admin"
                locked={currentUser.id == user.id}
                on={user.master}
              />
            </div>
          </Col>
        </Row>
      </Grid>
      <hr />
    </>
  );
};

function mapStateToPros(state) {
  return {
    currentUser: state.currentUser
  };
}

function mapDispatchToProps(dispatch) {
  return {
    toggleMasterFlag: actions.toggleMasterFlag(dispatch),
    toggleEnabledFlag: actions.toggleEnabledFlag(dispatch)
  };
}

export default connect(
  mapStateToPros,
  mapDispatchToProps
)(UserListItem);
