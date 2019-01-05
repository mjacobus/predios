class ContactAttemptController extends AppController {
  static get targets() {
    return [
      "showForm",
      "cancelButton",
      "confirmButton",
      "failButton",
      "cancel",
      "formContainer",
      "number",
      "time",
      "buildingNumber",
      "apartmentId",
      "apartmentUuid",
      "submitButton"
    ];
  }

  showForm(e) {
    e.preventDefault();
    this.showElement(this.formContainerTarget);
    this.hideElement(this.showFormTarget);
  }

  cancel(e) {
    e.preventDefault();
    this.hideElement(this.formContainerTarget);
    this.showElement(this.showFormTarget);
  }

  confirmContact(e) {
    e.preventDefault();

    if (!confirm(e.target.getAttribute('data-confirm'))) {
      return;
    }

    this.submit('contacted');
  }

  confirmFailure(e) {
    e.preventDefault();

    if (!confirm(e.target.getAttribute('data-confirm'))) {
      return;
    }

    this.submit('failed');
  }

  submit(outcome) {
    this.startLoader();
    this.disableActions();
    apiPost(this.endpoint, this.payload(outcome)).then((response, other) => {
      return response.json().then(jsonResponse => {
        this.handleResponse(jsonResponse, response);
      });
    })
  }

  handleResponse(jsonResponse, response) {
    this.enableActions();
    this.stopLoader();

    if (response.status >= 200 && response.status < 300) {
      const url = `/buildings/${this.buildingNumber}`
      Turbolinks.visit(url)
      return
    }

    console.log("Oops, algo deu errado");
  }

  get endpoint() {
    return `/api/buildings/${this.buildingNumber}/apartments/${this.apartmentId}/assign_visit_attempt`
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

    if (time == '') {
      delete contact_attempt.time;
    }

    return { contact_attempt };
  }

  disableActions() {
    this.failButtonTarget.disabled = false;
    this.cancelButtonTarget.disabled = false;
    this.confirmButtonTarget.disabled = false;
  }

  enableActions() {
    this.failButtonTarget.disabled = true;
    this.cancelButtonTarget.disabled = true;
    this.confirmButtonTarget.disabled = true;
  }
}
