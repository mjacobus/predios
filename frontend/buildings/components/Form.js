import React from "react";
import { InputField, Form, FormRow } from "../../library";
import { PageBlock } from "../../shared/components";

const MOCK_BUILDING = {
  number: "Number"
};

export default function BuildingForm({
  _building = MOCK_BUILDING,
  updating,
  ...formProps
}) {
  const building = MOCK_BUILDING;
  return (
    <PageBlock>
      <Form {...formProps}>
        <FormRow>
          <InputField
            defaultValue={building.number}
            name="number"
            readOnly={true}
            label="Número"
          />
        </FormRow>
        <FormRow>
          <InputField
            defaultValue={building.address}
            name="address"
            readOnly={true}
            label="Endereço"
          />
        </FormRow>
        <FormRow>
          <InputField
            defaultValue={building.name}
            name="name"
            readOnly={true}
            label="Nome do Condomínio"
          />
        </FormRow>
        <FormRow>
          <InputField
            defaultValue={building.number_of_apartments}
            name="number_of_apartments"
            readOnly={true}
            label="Número de Apartamentos"
          />
        </FormRow>
        <FormRow>
          <InputField
            defaultValue={building.neighborhood}
            name="neighborhood"
            readOnly={true}
            label="Bairro"
          />
        </FormRow>
        <p> has_individual_intercoms || has_individual_letterboxes </p>
      </Form>
    </PageBlock>
  );
}
