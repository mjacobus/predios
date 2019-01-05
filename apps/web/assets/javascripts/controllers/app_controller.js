class AppController extends Stimulus.Controller {
  hideElement(element) {
    element.style.display = 'none';
  }

  showElement(element) {
    element.style.display = 'block';
  }

  stopLoader() {
    if(!Turbolinks.supported) { return; }

    Turbolinks.controller.adapter.progressBar.hide();
  }

  startLoader() {
    if(!Turbolinks.supported) { return; }
    Turbolinks.controller.adapter.progressBar.setValue(0);
    Turbolinks.controller.adapter.progressBar.show();
  }
}
