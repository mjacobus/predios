import React from "react";
import { connect } from "react-redux";
import { css } from "glamor";
import { Input, Button, Form } from "../../../library";
import { colors, styles } from "../../../library/styles";
import { filterBuildings } from "../../actions";
import { Label, FormRow } from "../../../library";
import { Float } from "../../../shared/components";

function merge(original, replacements) {
  return Object.assign({}, original, replacements);
}

const Filter = ({ filter, ...props }) => {
  const mergeFilter = newProps => {
    props.filterBuildings(merge(filter, newProps));
  };

  const resetForm = () => {
    mergeFilter({ text: "", callOption: "all" });
  };

  const handleCallOptionChange = event => {
    const callOption = event.target.value;
    props.filterBuildings(merge(filter, { callOption }));
  };

  return (
    <div className={styles.formContainer}>
      <Form>
        <FormRow>
          <strong>PRÉDIOS</strong>
        </FormRow>
        <FormRow>
          <Label>
            <input
              type="radio"
              value="all"
              name="callOption"
              onChange={handleCallOptionChange}
              checked={filter.callOption == "all"}
            />{" "}
            Todos
          </Label>
          <Label>
            <input
              type="radio"
              value="intercom"
              name="callOption"
              onChange={handleCallOptionChange}
              checked={filter.callOption == "intercom"}
            />{" "}
            Interfone
          </Label>
          <Label>
            <input
              type="radio"
              value="phone"
              name="callOption"
              onChange={handleCallOptionChange}
              checked={filter.callOption == "phone"}
            />{" "}
            Telefone
          </Label>
          <Label>
            <input
              type="radio"
              value="letter"
              name="callOption"
              onChange={handleCallOptionChange}
              checked={filter.callOption == "letter"}
            />{" "}
            Cartas
          </Label>
        </FormRow>
        <FormRow>
          <Input
            className={css({ width: "70%", marginRight: "15px" })}
            name="filter"
            value={filter.text}
            placeholder="Filtro"
            type="text"
            onChange={e => mergeFilter({ text: e.target.value })}
          />
          <Float>
            <Button type="button" color={"jwBlue"} onClick={resetForm}>
              Limpar
            </Button>
          </Float>
        </FormRow>
      </Form>
    </div>
  );
};

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

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(Filter);
