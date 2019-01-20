import React from "react";
import { Navbar, Nav, NavItem, NavDropdown, MenuItem } from "react-bootstrap";

export default function AppNavbar() {
  return (
    <Navbar>
      <Navbar.Header>
        <Navbar.Brand>
          <a href="/">Página inicial</a>
        </Navbar.Brand>
        <Navbar.Toggle />
      </Navbar.Header>
      <Navbar.Collapse>
        <Nav>
          <NavItem eventKey={1} href="/buildings"> Prédios </NavItem>
          <NavItem eventKey={2} href="/Users"> Usuários </NavItem>
          <NavDropdown eventKey={3} title="Perfil" id="basic-nav-dropdown">
            <MenuItem eventKey={3.2}>Template</MenuItem>
            <MenuItem eventKey={3.3}>Template</MenuItem>
            <MenuItem divider />
            <MenuItem eventKey={3.1} href="/logout">Sair</MenuItem>
          </NavDropdown>
        </Nav>
      </Navbar.Collapse>
    </Navbar>
  );
}
