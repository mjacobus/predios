(() => {
  $(document).ready(() => {
    $("form[data-js]").submit(e => {
      const message = $(e.target).find("[data-confirmation]");

      if (message && !confirm(message.val())) {
        e.preventDefault();
      }
    });

    $(".datetime").datetimepicker();
  });
})(jQuery);

(() => {
  const application = Stimulus.Application.start();
  application.register("apartments", ApartmentsController);
  application.register("contact-attempt", ContactAttemptController);
  application.register("dialog", DialogController);
  application.register("building_form", BuildingFormController);
})();

const apiRequest = (url, data, method = "POST") => {
  console.log('method', method)
  console.log('url', url)
  console.log('data', data)
  const config = {
    method: method,
    mode: "cors", // no-cors, cors, *same-origin
    cache: "no-cache", // *default, no-cache, reload, force-cache, only-if-cached
    credentials: "same-origin", // include, *same-origin, omit
    headers: { "Content-Type": "application/json; charset=utf-8" },
    redirect: "follow", // manual, *follow, error
    referrer: "no-referrer", // no-referrer, *client
    body: JSON.stringify(data) // body data type must match "Content-Type" header
  };
  return fetch(url, config);
};

const apiPost = (url, data) => {
  return apiRequest(url, data, "POST");
};

const apiPut = (url, data) => {
  return apiRequest(url, data, "PUT");
};

const apiPatch = (url, data) => {
  return apiRequest(url, data, "PATCH");
};
