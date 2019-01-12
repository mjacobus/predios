class ContactAttemptController extends AppController {
  static get targets() {
    return [
      "errorMessage",
      "number",
      "time",
      "buildingNumber",
      "apartmentId",
      "apartmentUuid"
    ];
  }

  confirmContact(e) {
    e.preventDefault();
    this.submit("contacted");
  }

  submitFailure(e) {
    e.preventDefault();
    this.submit("failed");
  }

  submit(outcome) {
    this.startLoader();
    apiPost(this.endpoint, this.payload(outcome)).then((response, other) => {
      return response.json().then(jsonResponse => {
        this.handleResponse(jsonResponse, response);
      });
    });
  }

  handleResponse(jsonResponse, response) {
    if (response.status >= 200 && response.status < 300) {
      const url = `/buildings/${this.buildingNumber}`;
      Turbolinks.visit(url);
      return;
    }

    this.showError(jsonResponse.message);
    this.stopLoader();
  }

  get endpoint() {
    return `/api/buildings/${this.buildingNumber}/apartments/${
      this.apartmentId
    }/assign_visit_attempt`;
  }

  get apartmentId() {
    return this.apartmentIdTarget.value;
  }

  get apartmentUuid() {
    return this.apartmentUuidTarget.value;
  }

  get buildingNumber() {
    return this.buildingNumberTarget.value;
  }

  get time() {
    return this.timeTarget.value.toString();
  }

  payload(outcome) {
    const apartment_id = this.apartmentUuid;
    const time = this.time;
    const contact_attempt = { outcome, apartment_id, time };

    if (time == "") {
      delete contact_attempt.time;
    }

    return { contact_attempt };
  }

  showError(message) {
    this.showElement(this.errorMessageTarget);
    this.errorMessageTarget.innerHTML = message;
  }
}
