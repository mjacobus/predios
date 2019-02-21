import React from "react";

import { Label } from "../../../library";

export default class ContactAttemptOptions extends React.Component {
  constructor(props) {
    super(props);
    this.state = { value: props.defaultValue };
    this.onChange = this.onChange.bind(this);
  }

  onChange(e) {
    const value = e.target.value;
    this.setState({ value });
    return this.props.onChange(e);
  }

  render() {
    return (
      <div>
        <Label>
          <input
            type="radio"
            value="intercom"
            name="type"
            onChange={this.onChange}
            checked={this.state.value == "intercom"}
          />{" "}
          Interfone
        </Label>
        <Label>
          <input
            type="radio"
            value="phone"
            name="type"
            onChange={this.onChange}
            checked={this.state.value == "phone"}
          />{" "}
          Telefone
        </Label>
        <Label>
          <input
            type="radio"
            value="letter"
            name="type"
            onChange={this.onChange}
            checked={this.state.value == "letter"}
          />{" "}
          Carta
        </Label>
      </div>
    );
  }
}
