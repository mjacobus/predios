import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["container"];

  click(e) {
    e.preventDefault();

    const element = this.containerTarget;

    element.innerHTML += "<p>It works!<p>";
  }
}
