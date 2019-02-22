import React from "react";
import { SelectField, InputField, Form, FormRow } from "../../library";
import { PageBlock } from "../../shared/components";

const MOCK_BUILDING = {
  number: "Number"
};

const optionalBooleanValue = value => {
  if (value === undefined) {
    return "";
  }

  if (value === true) {
    return "1";
  }

  if (value === false) {
    return "0";
  }
};

const selectOptions = [
  { value: "", description: "Não sabemos" },
  { value: "1", description: "Sim" },
  { value: "0", description: "Não" }
];

const makeOnChangeHandler = onAttributeChange => {
  return event => {
    onAttributeChange(event.target.name, event.target.value);
  };
};

export default function BuildingForm({
  _building = MOCK_BUILDING,
  onAttributeChange,
  updating,
  building,
  ...formProps
}) {
  return (
    <PageBlock>
      <Form {...formProps}>
        <FormRow>
          <InputField
            defaultValue={building.number}
            name="number"
            disabled={true}
            label="Número"
          />
        </FormRow>
        <FormRow>
          <InputField
            onChange={makeOnChangeHandler(onAttributeChange)}
            defaultValue={building.address}
            name="address"
            label="Endereço"
          />
        </FormRow>
        <FormRow>
          <InputField
            onChange={makeOnChangeHandler(onAttributeChange)}
            defaultValue={building.name}
            name="name"
            label="Nome do Condomínio"
          />
        </FormRow>
        <FormRow>
          <InputField
            onChange={makeOnChangeHandler(onAttributeChange)}
            defaultValue={building.number_of_apartments}
            name="number_of_apartments"
            label="Número de Apartamentos"
          />
        </FormRow>
        <FormRow>
          <InputField
            onChange={makeOnChangeHandler(onAttributeChange)}
            defaultValue={building.neighborhood}
            name="neighborhood"
            readOnly={true}
            label="Bairro"
          />
        </FormRow>
        <FormRow>
          <SelectField
            onChange={makeOnChangeHandler(onAttributeChange)}
            name="has_individual_intercoms"
            defaultValue={optionalBooleanValue(
              building.has_individual_intercoms
            )}
            readOnly={true}
            label="Tem interfones individuais?"
            options={selectOptions}
          />
        </FormRow>
        <FormRow>
          <SelectField
            onChange={makeOnChangeHandler(onAttributeChange)}
            name="has_individual_letterboxes"
            defaultValue={optionalBooleanValue(
              building.has_individual_letterboxes
            )}
            readOnly={true}
            label="Tem caixinhas individuais de corrêio?"
            options={selectOptions}
          />
        </FormRow>
      </Form>
    </PageBlock>
  );
}
