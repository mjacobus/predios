import BaseController from "./base_controller";

export default class DialogController extends BaseController {
  static get targets() {
    return ["container"];
  }

  open(e) {
    e.preventDefault();
    this.showElement(this.containerTarget);
  }

  close(e) {
    e.preventDefault();
    this.hideElement(this.containerTarget);
  }
}
