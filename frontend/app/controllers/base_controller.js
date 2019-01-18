import { Controller } from "stimulus";

export default class BaseController extends Controller {
  hideElement(element) {
    element.style.display = "none";
  }

  showElement(element) {
    element.style.display = "block";
  }

  stopLoader() {
    this.hideElement(this.loader);
  }

  startLoader() {
    this.showElement(this.loader);
  }

  get loader() {
    return document.getElementById("ajax-loader");
  }
}
