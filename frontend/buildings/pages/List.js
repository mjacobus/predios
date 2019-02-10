import React from "react";
import { Grid, Col, Row } from "react-bootstrap";
import { css } from "glamor";
import { H1 } from "../../library";
import { Loader } from "../../library";
import Filter from "./list/Filter";
import Building from "./list/Building";

export default function BuildingsIndex(props) {
  const { filter, buildings, currentUser, fetching } = props;
  return (
    <div>
      <H1>Edifícios</H1>
      {fetching && <Loader />}
      {fetching || <Filter filter={filter} />}
      {fetching ||
        buildings.map((building, i) => (
          <Building building={building} key={i} />
        ))}
    </div>
  );
}
