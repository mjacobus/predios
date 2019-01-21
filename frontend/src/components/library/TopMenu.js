import React from "react";
import { Navbar, Nav, NavItem, NavDropdown, MenuItem } from "react-bootstrap";

export default function AppNavbar(props) {
  const user = props.currentUser;
  return (
    <Navbar>
      <Navbar.Header>
        <Navbar.Brand>
          <a href="/">Home</a>
        </Navbar.Brand>
        <Navbar.Toggle />
      </Navbar.Header>
      <Navbar.Collapse>
        <Nav>
          <NavItem eventKey={1} href="/buildings">
            {" "}
            Prédios{" "}
          </NavItem>
          {user.master && (
            <NavItem eventKey={2} href="/Users">
              {" "}
              Usuários{" "}
            </NavItem>
          )}
          {user.master && (
            <NavItem eventKey={3} href="/audits">
              {" "}
              Auditoria{" "}
            </NavItem>
          )}
          <NavDropdown eventKey={4} title={user.name} id="basic-nav-dropdown">
            <MenuItem eventKey={4.1}>{user.email}</MenuItem>
            <MenuItem divider />
            <MenuItem eventKey={4.3} href="/logout">
              Sair
            </MenuItem>
          </NavDropdown>
        </Nav>
      </Navbar.Collapse>
    </Navbar>
  );
}
