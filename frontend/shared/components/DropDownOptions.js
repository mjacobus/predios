import React from "react";
import { css } from "glamor";
import Icon from "../../library/Icon";
import { styles } from "../../library/styles";

const CloseElement = props => {
  return (
    <span className={styles.floatRight}>
      <Icon type="angle-double-up" />
    </span>
  );
};

const OpenElement = props => {
  return (
    <span className={styles.floatRight}>
      <Icon type="angle-double-down" />
    </span>
  );
};

export default class DropDownOptions extends React.Component {
  constructor(props) {
    super(props);
    this.state = { collapsed: true };
    this.toggle = this.toggle.bind(this);
  }

  toggle(e) {
    e.preventDefault();
    const collapsed = !this.state.collapsed;
    this.setState({ collapsed });
  }

  render() {
    const { children, ...otherProps } = this.props;
    const { collapsed } = this.state;

    return (
      <div {...otherProps}>
        {collapsed && (
          <a href="#" onClick={this.toggle}>
            <OpenElement />
          </a>
        )}
        {collapsed || (
          <a href="#" onClick={this.toggle}>
            <CloseElement />
          </a>
        )}
        <div>{collapsed || <div>{children}</div>}</div>
      </div>
    );
  }
}
