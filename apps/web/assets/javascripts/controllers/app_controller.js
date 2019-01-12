class AppController extends Stimulus.Controller {
  hideElement(element) {
    element.style.display = "none";
  }

  showElement(element) {
    element.style.display = "block";
  }

  stopLoader() {
    this.hideElement(this.loader);

    if (!Turbolinks.supported) {
      return;
    }

    Turbolinks.controller.adapter.progressBar.hide();
  }

  startLoader() {
    this.showElement(this.loader);

    if (!Turbolinks.supported) {
      return;
    }
    Turbolinks.setProgressBarDelay(0);
    Turbolinks.controller.adapter.progressBar.setValue(0);
    Turbolinks.controller.adapter.progressBar.show();
  }

  get loader() {
    return document.getElementById("ajax-loader");
  }
}
