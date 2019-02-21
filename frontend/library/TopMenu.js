import React from "react";
import { Navbar, Nav, NavItem, NavDropdown, MenuItem } from "react-bootstrap";
import { withRouter } from "react-router-dom";

const linkTo = (location, history) => {
  return e => {
    e.preventDefault();
    document.querySelector(".navbar-toggle").click();
    history.push(location);
  };
};

const TopMenu = ({ currentUser, history, app_version_url }) => {
  return (
    <Navbar fixedTop={true}>
      <Navbar.Header>
        <Navbar.Brand>
          <img src={`${currentUser.avatar}?sz=25`} />
        </Navbar.Brand>
        <Navbar.Toggle />
      </Navbar.Header>
      <Navbar.Collapse>
        <Nav>
          <NavItem eventKey={1} href="/">
            {" "}
            Home{" "}
          </NavItem>
          <NavItem eventKey={1} onClick={linkTo("/buildings", history)}>
            {" "}
            Prédios{" "}
          </NavItem>
          {currentUser.master && (
            <NavItem eventKey={2} href="/users">
              {" "}
              Usuários{" "}
            </NavItem>
          )}
          {currentUser.master && (
            <NavItem eventKey={3} href="/audits">
              {" "}
              Auditoria{" "}
            </NavItem>
          )}
          <NavDropdown
            eventKey={4}
            title={currentUser.name}
            id="basic-nav-dropdown"
          >
            <MenuItem eventKey={4.1}>{currentUser.email}</MenuItem>
            <MenuItem eventKey={4.2} href={app_version_url}>
              Versão
            </MenuItem>
            <MenuItem divider />
            <MenuItem eventKey={4.3} href="/logout">
              Sair
            </MenuItem>
          </NavDropdown>
        </Nav>
      </Navbar.Collapse>
    </Navbar>
  );
};

export default withRouter(TopMenu);
