import Popover from "@stimulus-components/popover";
import { computePosition } from "@floating-ui/dom";

export default class extends Popover {
  async show(event) {
    let el = event.currentTarget;
    let content = `<div class="floating" data-tooltip-target="card">${this.element.dataset.tooltip}</div>`;
    let target = document.createRange().createContextualFragment(content)
      .children[0];
    computePosition(el, target, {
      placement: "top",
    }).then(({ x, y }) => {
      Object.assign(target.style, {
        left: `${x}px`,
        top: `${y}px`,
      });
    });

    this.element.append(target);
  }
}
