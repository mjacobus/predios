const apiRequest = (url, data, method = "POST") => {
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

export const apiPost = (url, data) => {
  return apiRequest(url, data, "POST");
};

export const apiPatch = (url, data) => {
  return apiRequest(url, data, "PATCH");
};

export const apiDelete = (url, data) => {
  return apiRequest(url, data, "DELETE");
};
