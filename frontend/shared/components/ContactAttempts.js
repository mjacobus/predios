import React from "react";
import ContactAttempt from "./ContactAttempt";

export default class ContactAttempts extends React.Component {
  constructor(props) {
    super(props);
    this.state = { open: false };
    this.toggle = this.toggle.bind(this);
  }

  toggle() {
    this.setState({ open: !this.state.open });
  }

  render() {
    const attempts = this.props.contactAttempts.slice().reverse();

    if (attempts.length == 0) {
      return <span />;
    }

    const first = attempts.shift();

    let firstEntry = <ContactAttempt contactAttempt={first} />;

    if (attempts.length > 0) {
      firstEntry = <a onClick={this.toggle}>{firstEntry}</a>;
    }

    return (
      <div>
        {firstEntry}
        {this.state.open &&
          attempts.map((attempt, key) => (
            <ContactAttempt contactAttempt={attempt} key={key} />
          ))}
      </div>
    );
  }
}
