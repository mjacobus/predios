import React from "react";
import { css } from "glamor";
import Icon from "../../library/Icon";

const containerClass = css({
  padding: "4px",
  border: "1px solid white"
});

const closeButtonClass = css({
  float: "right"
});

const CloseElement = props => {
  return (
    <span className={closeButtonClass}>
      <Icon type="angle-double-up" />
    </span>
  );
};

const OpenElement = props => {
  return (
    <span className={closeButtonClass}>
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
    const { children } = this.props;
    const { collapsed } = this.state;

    return (
      <>
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
        <div className={containerClass}>
          {collapsed || <div>{children}</div>}
        </div>
      </>
    );
  }
}
