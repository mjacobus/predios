import React from "react";
import { connect } from "react-redux";
import { css } from "glamor";
import { H1, Input, Button, Form } from "../../../library";
import { colors, styles } from "../../../library/styles";
import { filterBuildings } from "../../actions";
import { Label, FormRow } from "../../../library";

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

function merge(original, replacements) {
  return Object.assign({}, original, replacements);
}

const Filter = props => {
  const mergeFilter = newProps => {
    props.filterBuildings(merge(props.filter, newProps));
  };

  const resetForm = () => {
    mergeFilter({ text: "", callOption: "all" });
  };

  const handleCallOptionChange = event => {
    const callOption = event.target.value;
    props.filterBuildings(merge(props.filter, { callOption }));
  };

  return (
    <div className={styles.formContainer}>
      <Form>
        <FormRow>
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
        </FormRow>
        <FormRow>
          <Input
            autoFocus={true}
            className={css({ width: "70%", marginRight: "15px" })}
            placeholder="Filtro"
            type="text"
            onKeyUp={e => mergeFilter({ text: e.target.value })}
          />
          <Button type="reset" color={"jwBlue"} onClick={resetForm}>
            Limpar
          </Button>
        </FormRow>
      </Form>
    </div>
  );
};

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(Filter);
