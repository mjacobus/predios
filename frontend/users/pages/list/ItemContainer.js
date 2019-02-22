import React from "react";
import { connect } from "react-redux";
import actions from "../../actions";

const UserListItem = ({ user }) => {
  return <>{user.name}</>;
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
