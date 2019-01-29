import { get, post } from "superagent";

const apiRequest = request => {
  return request.type("json").accept("json");
};

export function apiGet(url) {
  return apiRequest(get(url));
}

export function apiPost(url) {
  return apiRequest(post(url));
}
