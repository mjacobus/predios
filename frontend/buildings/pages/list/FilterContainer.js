import React from "react";
import { connect } from "react-redux";
import { css } from "glamor";
import { H1, Input, Button, Form } from "../../../library";
import { colors, styles } from "../../../library/styles";
import { filterBuildings } from "../../actions";

function mapStateToProps(state) {
  return {
    fetching: state.buildingsList.fetching,
    currentUser: state.currentUser,
    buildings: state.entities.buildings
  };
}

function mapDispatchToProps(dispatch) {
  return {
    filterBuildings: filterBuildings(dispatch)
  };
}

const Filter = props => {
  return (
    <div className={styles.formContainer}>
      <Form>
        <Input
          className={css({ width: "70%", marginRight: "15px" })}
          placeholder="Filtro"
          type="text"
          onKeyUp={e => props.filterBuildings(e.target.value)}
        />
        <Button
          type="reset"
          color={"jwBlue"}
          onClick={() => props.filterBuildings("")}
        >
          Limpar
        </Button>
      </Form>
    </div>
  );
};

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(Filter);
