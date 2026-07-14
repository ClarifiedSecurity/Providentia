import Popover from "@stimulus-components/popover";
import { computePosition, shift } from "@floating-ui/dom";

export default class extends Popover {
  tooltip;

  async show(event) {
    let el = event.currentTarget;
    let content = `<div class="floating" data-tooltip-target="card">${this.element.dataset.tooltip}</div>`;
    this.tooltip = document.createRange().createContextualFragment(content)
      .children[0];
    computePosition(el, this.tooltip, {
      placement: "top",
      middleware: [shift()],
    }).then(({ x, y }) => {
      Object.assign(this.tooltip.style, {
        left: `${x}px`,
        top: `${y}px`,
      });
    });

    this.element.append(this.tooltip);
  }

  disconnect() {
    if (this.tooltip) {
      this.tooltip.remove();
    }
  }
}
