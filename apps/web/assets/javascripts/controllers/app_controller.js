class AppController extends Stimulus.Controller {
  hideElement(element) {
    element.style.display = 'none';
  }

  showElement(element) {
    element.style.display = 'block';
  }
}
