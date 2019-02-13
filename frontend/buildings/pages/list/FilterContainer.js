import React from "react";
import { connect } from "react-redux";
import { css } from "glamor";
import { H1, Input, Button, Form } from "../../../library";
import { colors, styles } from "../../../library/styles";
import { filterBuildings, selectContactOption } from "../../actions";
import { Label } from "../../../library";

function mapStateToProps(state) {
  return {
    filter: state.buildingsList.filter,
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
  const resetForm = () => {
    props.filterBuildings("text", "", props.filter);
    props.filterBuildings("callOption", "", props.filter);
  };

  const handleCallOptionChange = event => {
    props.filterBuildings("callOption", event.target.value);
  };

  return (
    <div className={styles.formContainer}>
      <Form>
        <Input
          autoFocus={true}
          className={css({ width: "70%", marginRight: "15px" })}
          placeholder="Filtro"
          type="text"
          onKeyUp={e => props.filterBuildings("text", e.target.value)}
        />
        <Button type="reset" color={"jwBlue"} onClick={() => resetForm()}>
          Limpar
        </Button>
        <Label>
          <input
            type="radio"
            value="intercom"
            name="callOption"
            onChange={handleCallOptionChange}
            checked={props.filter.callOption == "intercom"}
          />{" "}
          Interfone
        </Label>
        <Label>
          <input
            type="radio"
            value="phone"
            name="callOption"
            onChange={handleCallOptionChange}
            checked={props.filter.callOption == "phone"}
          />{" "}
          Telefone
        </Label>
        <Label>
          <input
            type="radio"
            value="letter"
            name="callOption"
            onChange={handleCallOptionChange}
            checked={props.filter.callOption == "letter"}
          />{" "}
          Cartas
        </Label>
        <Label>
          <input
            type="radio"
            value="all"
            name="callOption"
            onChange={handleCallOptionChange}
            checked={props.filter.callOption == "all"}
          />{" "}
          Todos
        </Label>
      </Form>
    </div>
  );
};

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(Filter);
