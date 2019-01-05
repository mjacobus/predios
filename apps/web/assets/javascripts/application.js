(() => {
  $(document).ready(() => {
    $('form[data-js]').submit((e) => {
      const message = $(e.target).find('[data-confirmation]');

      if (message && !confirm(message.val())) {
        e.preventDefault();
      }
    });

    $('.datetime').datetimepicker();
  })
})(jQuery);

(() => {
  const application = Stimulus.Application.start()
  application.register("apartments", ApartmentsController);
  application.register("contact-attempt", ContactAttemptController);
  Turbolinks.setProgressBarDelay(0);
})()

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
