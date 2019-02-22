import { get, post, put, patch, del } from "superagent";

const apiRequest = request => {
  return request.type("json").accept("json");
};

export function apiGet(url) {
  return apiRequest(get(url));
}

export function apiPost(url) {
  return apiRequest(post(url));
}

export function apiPut(url) {
  return apiRequest(put(url));
}

export function apiPatch(url) {
  return apiRequest(patch(url));
}

export function apiDelete(url) {
  return apiRequest(del(url));
}
