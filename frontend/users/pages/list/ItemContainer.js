import React from "react";
import { connect } from "react-redux";
import actions from "../../actions";
import { Grid, Col, Row, Title, Toggler } from "../../../library";

const UserListItem = ({ user }) => {
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
          <Col xs={5}>
            <Toggler
              entity={user}
              toggler={() => {}}
              label="Enabled"
              on={user.enabled}
            />
          </Col>
          <Col xs={5}>
            <Toggler
              entity={user}
              toggler={() => {}}
              label="Admin"
              on={user.master}
            />
          </Col>
        </Row>
      </Grid>
      <hr />
    </>
  );
};

function mapStateToPros(state) {
  return {};
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
