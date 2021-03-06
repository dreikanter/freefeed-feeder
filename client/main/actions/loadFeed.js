import axios from 'axios'
import { pending, fulfilled, rejected } from 'lib/utils/promiseHelpers'
import paths from 'main/paths'

export const LOAD_FEED = 'main/LOAD_FEED'

export const LOAD_FEED_PENDING = pending(LOAD_FEED)

export const LOAD_FEED_FULFILLED = fulfilled(LOAD_FEED)

export const LOAD_FEED_REJECTED = rejected(LOAD_FEED)

export function loadFeed (name) {
  return {
    type: LOAD_FEED,
    meta: { name },
    payload: axios.get(paths.apiFeedPath(name))
  }
}
