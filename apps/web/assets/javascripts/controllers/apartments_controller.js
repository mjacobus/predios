class ApartmentsController extends AppController {
  static get targets() {
    return [
      "number",
      "errorMessage",
      "buildingNumber",
      "buildingId",
      "buildingUuid",
      "submitButton"
    ];
  }

  submitForm(e) {
    e.preventDefault();
    this.startLoader();

    if (this.formDisabled) {
      return;
    }

    this.createApartment();
  }

  createApartment() {
    this.beforeCreate();
    apiPost(this.apartmentsEndpoint, this.payload).then((response, other) => {
      return response.json().then(jsonResponse => {
        this.handleResponse(jsonResponse, response);
      });
    })
    .catch(error => alert('error'))
  }

  enableForm() {
    this.formDisabled = false;
    this.submitButtonTarget.disabled = false;
  }

  beforeCreate() {
    this.disableForm();
    this.hideElement(this.errorMessageTarget);
    this.stopLoader();
  }

  disableForm() {
    this.formDisabled = true;
    this.submitButtonTarget.disabled = true;
  }

  handleResponse(jsonResponse, response) {
    this.enableForm();

    if (response.status >= 200 && response.status < 300) {
      Turbolinks.visit(this.buildingUrl)
      return
    }

    const feedback = this.errorMessageTarget;
    feedback.innerHTML = jsonResponse.message;
    this.showElement(feedback);
  }

  get payload() {
    const number = this.number;
    const buildingUuid = this.buildingUuid;
    const apartment = { number, building_id: buildingUuid };
    return { apartment }
  }

  get buildingUrl() {
    return `/buildings/${this.buildingNumber}`
  }

  get apartmentsEndpoint() {
    return `/api/buildings/${this.buildingNumber}/apartments`
  }

  get number() {
    return this.numberTarget.value;
  }

  get buildingId() {
    return this.buildingIdTarget.value;
  }

  get buildingUuid() {
    return this.buildingUuidTarget.value;
  }

  get buildingNumber() {
    return this.buildingNumberTarget.value;
  }
}
