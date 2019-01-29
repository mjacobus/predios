import React from "react";
import { connect } from "react-redux";
import { Input } from "../library/html";

function mapStateToProps(state) {
  return {};
}

function mapDispatchToProps(dispatch) {
  return {};
}

class ApartmentForm extends React.Component {
  render() {
    return (
      <div>
        <form onSubmit={this.props.submitHandler}>
          <Input placeholder="número" type="text" />
          <Input type="submit" value="Submit" />
        </form>
      </div>
    );
  }
}

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(ApartmentForm);
