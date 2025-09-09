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
