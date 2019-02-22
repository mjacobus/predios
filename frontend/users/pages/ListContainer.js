import React from "react";
import { connect } from "react-redux";
import { Loader } from "../../library";
import actions from "../actions";
import UserListItem from "./list/ItemContainer";
import { PageBlock } from "../../shared/components";

import { H1, Col, Row } from "../../library";

const Users = ({ users }) => {
  return (
    <div>
      {users.map((user, key) => (
        <UserListItem user={user} key={key} />
      ))}
    </div>
  );
};

class UsersList extends React.Component {
  constructor(props) {
    super(props);
  }

  componentDidMount() {
    this.props.fetchUsers();
  }

  render() {
    const { users, fetching } = this.props;

    if (fetching) {
      return <Loader />;
    }

    return (
      <>
        <PageBlock>
          <H1>Usuários</H1>
        </PageBlock>
        <Users users={users} />
      </>
    );
  }
}

function mapStateToPros(state) {
  return {
    users: state.usersList.users
  };
}

function mapDispatchToProps(dispatch) {
  return {
    fetchUsers: actions.fetchUsers(dispatch)
  };
}

export default connect(
  mapStateToPros,
  mapDispatchToProps
)(UsersList);
