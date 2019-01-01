class ContactAttemptController extends AppController {
  static get targets() {
    return [
      "showForm",
      "cancel",
      "formContainer",
      "number",
      "buildingId",
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

  confirmContacted(e) {
    e.preventDefault();
    if (!confirm(e.target.getAttribute('data-confirm'))) {
      this.cancel(e);
    }
  }

  confirmFailed(e) {
    e.preventDefault();

    if (!confirm(e.target.getAttribute('data-confirm'))) {
      this.cancel(e);
    }
  }
}
