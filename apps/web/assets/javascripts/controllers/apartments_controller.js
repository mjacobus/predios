const apiRequest = (url, data, method = 'POST') => {
  const config = {
    method: method,
    mode: "cors", // no-cors, cors, *same-origin
    cache: "no-cache", // *default, no-cache, reload, force-cache, only-if-cached
    credentials: "same-origin", // include, *same-origin, omit
    headers: { "Content-Type": "application/json; charset=utf-8" },
    redirect: "follow", // manual, *follow, error
    referrer: "no-referrer", // no-referrer, *client
    body: JSON.stringify(data), // body data type must match "Content-Type" header
  }
  return fetch(url, config);
}

const apiPost = (url, data) => {
  return apiRequest(url, data, 'POST');
};

class ApartmentsController extends Stimulus.Controller {
  static get targets() {
    return ["number", "code", "buildingId", "submitButton"];
  }

  submitForm(e) {
    e.preventDefault();

    if (this.formDisabled) {
      return;
    }

    this.createApartment();
  }

  createApartment() {
    this.disableForm();
    const enableForm = this.enableForm.bind(this);

    const feedback = this.codeTarget;
    apiPost(this.url, this.payload)
      .then((response, other) => {
        enableForm();
        return response.json();
      })
      .then(response => feedback.innerHTML = JSON.stringify(response))
    .catch(error => alert('error'))
  }

  enableForm() {
    this.formDisabled = false;
    this.submitButtonTarget.disabled = false;
  }

  disableForm() {
    this.formDisabled = true;
    console.log(this.submitButtonTarget)
    this.submitButtonTarget.disabled = true;
  }

  payload() {
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

