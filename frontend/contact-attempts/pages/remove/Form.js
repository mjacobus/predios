import React from "react";
import { Grid, Col, Row } from "react-bootstrap";
import { Button, A } from "../../../library";
import {
  BuildingHeader,
  ButtonGroup,
  ContactAttempt,
  PageBlock,
  Question
} from "../../../shared/components";
import { Label } from "../../../library";
import {
  selectIndexes,
  removeItem,
  duplicate
} from "../../../src/utils/collections";

export default class Form extends React.Component {
  constructor(props) {
    super(props);
    this.state = { indexesToRemove: [] };
    this.onAttemptChange = this.onAttemptChange.bind(this);
    this.submit = this.submit.bind(this);
    this.isEmpty = this.isEmpty.bind(this);
  }

  onAttemptChange(event) {
    let indexesToRemove = duplicate(this.state.indexesToRemove);
    const value = parseInt(event.target.value);
    indexesToRemove.push(value);

    if (!event.target.checked) {
      indexesToRemove = removeItem(value, indexesToRemove);
    }

    this.setState({ indexesToRemove });
  }

  submit(event) {
    event.preventDefault();
    const remove = selectIndexes(
      this.state.indexesToRemove,
      this.props.apartment.contact_attempts
    );
    this.props.submitValues({ remove });
  }

  isEmpty() {
    return this.state.indexesToRemove.length == 0;
  }

  render() {
    // TODO: Align checkbox
    const { apartment, building, submitHandler, value } = this.props;
    const submit = this.submit;

    return (
      <div>
        <BuildingHeader building={this.props.building} />
        <PageBlock>
          <Question>
            Quais tentativas de contado deseja remover do apartamento{" "}
            <span>
              <strong>apartamento {apartment.number}</strong>
            </span>
            ?
          </Question>
        </PageBlock>
        <PageBlock>
          {apartment.contact_attempts.map((attempt, index) => (
            <div key={index}>
              <Label>
                <input
                  type="checkbox"
                  name="contactAttempt"
                  value={index}
                  onChange={this.onAttemptChange}
                />
                <ContactAttempt contactAttempt={attempt} />
              </Label>
            </div>
          ))}
        </PageBlock>
        <PageBlock>
          <ButtonGroup>
            <Button
              style="red"
              disabled={this.props.removing || this.isEmpty()}
              onClick={submit}
            >
              Remover
            </Button>
            <A
              buttonStyle="blue"
              to={`/buildings/${building.number}/apartments`}
            >
              {" "}
              Cancelar{" "}
            </A>
          </ButtonGroup>
        </PageBlock>
      </div>
    );
  }
}
