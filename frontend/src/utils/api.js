import { get } from "superagent";

export function apiGet(url) {
  return get(url)
    .type('json')
    .accept('json');
}
