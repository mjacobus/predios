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

  confirm(e) {
    e.preventDefault();
    confirm('foo bar baz?')
  }
}
