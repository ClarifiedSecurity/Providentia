// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails";
import "controllers";
import "src/fonts";

// custom turbo action
Turbo.StreamActions.reload = function () {
  // if the frame has a `src`, reload
  // if not but has a data-src => load that src
  // else do nothing
  document.querySelectorAll(`turbo-frame#${this.target}`).forEach((frame) => {
    if (frame.src) {
      frame.reload();
    } else if (frame.dataset.src) {
      frame.src = frame.dataset.src;
    }
  });
};


// Cancel stale hover-prefetch requests on navigation.
//
// Turbo prefetches links on hover but, unlike a normal in-flight visit request, it does
// NOT cancel earlier prefetch requests when a new visit starts (hotwired/turbo#1244).
// Click through links quickly and a slower earlier prefetch can resolve LAST and "rewind"
// the page to one you already navigated away from. This keeps prefetch enabled and aborts
// only the stale ones (same idea as the upstream fix #1490). Remove once your Turbo
// version includes that fix.

const pendingPrefetches = new Map(); // destination href -> AbortController

// Turbo tags each hover-prefetch request with this header in LinkPrefetchObserver's
// prepareRequest. Normal visits, Turbo Frame loads, and form submits carry no such
// header, so they pass through untouched. (Currently "X-Sec-Purpose"; also accept the
// standard "Sec-Purpose" in case a future Turbo aligns with it, see #924.)
const isPrefetchRequest = (event) => {
  const headers = event.detail?.fetchOptions?.headers || {};
  return headers["X-Sec-Purpose"] === "prefetch" || headers["Sec-Purpose"] === "prefetch";
};

document.addEventListener("turbo:before-fetch-request", (event) => {
  if (typeof AbortSignal.any !== "function") return; // needs AbortSignal.any
  if (!isPrefetchRequest(event)) return;

  const { fetchOptions, url } = event.detail;
  const href = url?.href ?? String(url);

  // Repeated hovers over one link fire repeated prefetches; keep only the latest.
  pendingPrefetches.get(href)?.abort();

  const controller = new AbortController();
  // Combine with Turbo's own request signal so the fetch aborts on EITHER Turbo's own
  // cancellation or our stale-drop below.
  fetchOptions.signal = fetchOptions.signal
    ? AbortSignal.any([fetchOptions.signal, controller.signal])
    : controller.signal;
  pendingPrefetches.set(href, controller);
});

document.addEventListener("turbo:before-visit", (event) => {
  const destination = event.detail?.url; // href we're navigating to
  pendingPrefetches.forEach((controller, href) => {
    // Spare the destination's own prefetch so this visit can consume it, but KEEP IT
    // TRACKED. Clicking a prefetched link makes the visit adopt that request's promise
    // (FetchRequest#perform: `this.response = event.detail.fetchRequest.response`), after
    // which the visit's own abortController governs nothing and Visit.cancel() can't stop
    // it. That adopted request is the ONLY prefetch that can still paint a page you left,
    // so it's exactly the one the NEXT visit has to abort. Clearing the whole map here
    // (which an earlier version of this snippet did) leaves the bug live.
    if (href === destination) return;
    controller.abort();
    pendingPrefetches.delete(href);
  });
});
