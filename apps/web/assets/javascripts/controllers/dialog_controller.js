class DialogController extends AppController {
  static get targets() {
    return ["container"];
  }

  open(e) {
    e.preventDefault();
    this.showElement(this.containerTarget);
  }

  close(e) {
    e.preventDefault();
    this.hideElement(this.containerTarget);
  }
}
