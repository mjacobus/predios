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
    this.disableActions();
    apiPost(this.endpoint, this.payload(outcome)).then((response, other) => {
      return response.json().then(jsonResponse => {
        this.handleResponse(jsonResponse, response);
      });
    })
  }

  handleResponse(jsonResponse, response) {
    this.enableActions();

    if (response.status >= 200 && response.status < 300) {
      const url = `/api/buildings/${this.buildingNumber}/apartments/${this.apartmentId}`
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

  payload(outcome) {
    const apartment_id = this.apartmentUuid;
    return {
      contact_attempt: {
        outcome,
        apartment_id,
        time: '2001-02-03'
      }
    }
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
