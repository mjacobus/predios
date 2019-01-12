class ContactAttemptController extends AppController {
  static get targets() {
    return [
      "confirmButton",
      "failButton",
      "errorMessage",
      "number",
      "date",
      "time",
      "buildingNumber",
      "apartmentId",
      "apartmentUuid",
    ];
  }

  confirmContact(e) {
    e.preventDefault();

    if (!confirm(e.target.getAttribute("data-confirm"))) {
      return;
    }

    this.submit("contacted");
  }

  confirmFailure(e) {
    e.preventDefault();

    if (!confirm(e.target.getAttribute("data-confirm"))) {
      return;
    }

    this.submit("failed");
  }

  submit(outcome) {
    this.startLoader();
    this.disableActions();
    apiPost(this.endpoint, this.payload(outcome)).then((response, other) => {
      return response.json().then(jsonResponse => {
        this.handleResponse(jsonResponse, response);
      });
    });
  }

  handleResponse(jsonResponse, response) {
    this.enableActions();
    this.stopLoader();

    if (response.status >= 200 && response.status < 300) {
      const url = `/buildings/${this.buildingNumber}`;
      Turbolinks.visit(url);
      return;
    }

    this.showError(jsonResponse.message);
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
    return [
      this.timeTarget.value.toString(),
      this.timeTarget.value.toString(),
    ].join(" ").trim();
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

  disableActions() {
    this.failButtonTarget.disabled = false;
    this.confirmButtonTarget.disabled = false;
    this.hideElement(this.errorMessageTarget);
  }

  enableActions() {
    this.failButtonTarget.disabled = true;
    this.confirmButtonTarget.disabled = true;
  }
}
