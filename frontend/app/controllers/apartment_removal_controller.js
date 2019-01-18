import BaseController from "./base_controller";

import { apiDelete } from "../utils";

export default class ApartamentRemovalController extends BaseController {
  static get targets() {
    return ["apartmentUuid", "errorMessage", "container"];
  }

  submit(e) {
    e.preventDefault();
    this.startLoader();
    this.removeApartment();
  }

  removeApartment() {
    apiDelete(`/api/buildings/any/apartments/${this.apartmentUuid}`, {})
      .then((response, other) => {
        return response.json().then(jsonResponse => {
          this.handleResponse(jsonResponse, response);
        });
      })
      .catch(error => console.log(error));
  }

  beforeSubmit() {
    this.startLoader();
    this.hideElement(this.errorMessageTarget);
  }

  handleResponse(jsonResponse, response) {
    if (response.status == 202) {
      this.hideElement(
        document.getElementById(`apartment-${this.apartmentUuid}`)
      );
      this.stopLoader();
      return;
    }

    const feedback = this.errorMessageTarget;
    feedback.innerHTML = jsonResponse.message;
    this.showElement(feedback);
    this.stopLoader();
  }

  get apartmentUuid() {
    return this.apartmentUuidTarget.value;
  }
}
