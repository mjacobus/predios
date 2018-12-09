class ApartmentsController extends AppController {
  static get targets() {
    return [
      "number",
      "errorMessage",
      "buildingId",
      "submitButton"
    ];
  }

  submitForm(e) {
    e.preventDefault();

    if (this.formDisabled) {
      return;
    }

    this.createApartment();
  }

  createApartment() {
    this.beforeCreate();
    apiPost(this.url, this.payload).then((response, other) => {
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
  }

  disableForm() {
    this.formDisabled = true;
    this.submitButtonTarget.disabled = true;
  }

  handleResponse(jsonResponse, response) {
    this.enableForm();
    const feedback = this.errorMessageTarget;
    feedback.innerHTML = jsonResponse.message;
    this.showElement(feedback);
  }

  get payload() {
    const number = this.number;
    return { number };
  }

  get url() {
    return `/api/buildings/${this.buildingId}/apartments`
  }

  get number() {
    return this.numberTarget.value;
  }

  get buildingId() {
    return this.buildingIdTarget.value;
  }
}

