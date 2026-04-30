import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    // Map: url -> Array of controllers
    this.pendingControllers = new Map();
  }

  dropPrevVisits(event) {
    const currentUrl = event.detail.url;

    for (const [url, controllers] of this.pendingControllers.entries()) {
      if (url !== currentUrl) {
        // Different URL: abort all requests
        for (const controller of controllers) {
          try {
            controller.abort();
          } catch (_) {}
        }
        this.pendingControllers.delete(url);
      } else {
        // Same URL: keep only the last request, abort others
        if (controllers.length > 1) {
          const toAbort = controllers.slice(0, -1);
          for (const controller of toAbort) {
            try {
              controller.abort();
            } catch (_) {}
          }
          // Keep only the last one
          this.pendingControllers.set(url, [
            controllers[controllers.length - 1],
          ]);
        }
      }
    }
  }

  trackFetchRequest(event) {
    const url = event.detail.url.href;
    // Not sure why, but if fetchRequest doesn’t exist, it means this is a prefetch request
    if (event.detail.fetchRequest) return;

    event.preventDefault();

    const controller = new AbortController();

    // Combine with Turbo's existing signal
    const existingSignal = event.detail.fetchOptions.signal;
    if (existingSignal) {
      event.detail.fetchOptions.signal = AbortSignal.any([
        existingSignal,
        controller.signal,
      ]);
    } else {
      event.detail.fetchOptions.signal = controller.signal;
    }

    // Add controller to array for this URL
    if (!this.pendingControllers.has(url)) {
      this.pendingControllers.set(url, []);
    }
    this.pendingControllers.get(url).push(controller);

    // Cleanup when request finishes
    const cleanup = () => {
      const controllers = this.pendingControllers.get(url);
      if (controllers) {
        const idx = controllers.indexOf(controller);
        if (idx !== -1) controllers.splice(idx, 1);
        if (controllers.length === 0) this.pendingControllers.delete(url);
      }
    };

    const originalFetch = event.detail.fetch;
    if (originalFetch) {
      // Wrap fetch to cleanup on completion
      event.detail.fetch = (...args) => originalFetch(...args).finally(cleanup);
    }
    event.detail.resume();
  }
}
