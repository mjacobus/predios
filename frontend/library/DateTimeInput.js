import React from "react";
import DatePicker, { registerLocale } from "react-datepicker";
import ptBR from "date-fns/locale/pt-BR";
registerLocale("pt-BR", ptBR);

export default class DateTimeInput extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      date: new Date()
    };
    this.handleChange = this.handleChange.bind(this);
  }

  handleChange(date) {
    this.setState({
      date: date
    });
    this.props.onDateChange(this);
  }

  date() {
    return this.state.date;
  }

  render() {
    return (
      <DatePicker
        selected={this.state.date}
        onChange={this.handleChange}
        showTimeSelect
        locale="pt-BR"
        dateFormat="dd/MM/yyyy HH:mm"
      />
    );
  }
}
