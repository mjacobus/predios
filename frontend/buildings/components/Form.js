import React from "react";
import {
  SelectField,
  InputField,
  Form,
  FormRow,
  Button,
  A
} from "../../library";
import { ButtonGroup, PageBlock } from "../../shared/components";

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
  onAttributeChange,
  updating,
  building,
  errors = {},
  ...formProps
}) {
  return (
    <PageBlock>
      <Form {...formProps}>
        <FormRow>
          <InputField
            defaultValue={building.number}
            onChange={makeOnChangeHandler(onAttributeChange)}
            name="number"
            disabled={!!building.number}
            errors={errors.number}
            label="Número"
          />
        </FormRow>
        <FormRow>
          <InputField
            onChange={makeOnChangeHandler(onAttributeChange)}
            defaultValue={building.address}
            name="address"
            errors={errors.address}
            label="Endereço"
          />
        </FormRow>
        <FormRow>
          <InputField
            onChange={makeOnChangeHandler(onAttributeChange)}
            defaultValue={building.name}
            name="name"
            errors={errors.name}
            label="Nome do Condomínio"
          />
        </FormRow>
        <FormRow>
          <InputField
            onChange={makeOnChangeHandler(onAttributeChange)}
            defaultValue={building.number_of_apartments}
            name="number_of_apartments"
            errors={errors.number_of_apartments}
            label="Número de Apartamentos"
          />
        </FormRow>
        <FormRow>
          <InputField
            onChange={makeOnChangeHandler(onAttributeChange)}
            defaultValue={building.neighborhood}
            name="neighborhood"
            errors={errors.neighborhood}
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
            label="Tem caixinhas individuais de corrêio?"
            options={selectOptions}
          />
        </FormRow>
        <FormRow>
          <ButtonGroup>
            <A
              buttonStyle="purple"
              to={`/buildings/${building.number}/apartments`}
            >
              Cancelar
            </A>

            <Button type="submit" disabled={updating}>
              Salvar
            </Button>
          </ButtonGroup>
        </FormRow>
        <FormRow />
      </Form>
    </PageBlock>
  );
}
