import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["actorblock", "roleselector"];

  toggleActors() {
    this.actorblockTarget.classList.toggle(
      "hidden",
      !this.roleselectorTarget.value.match(/^actor_/)
    );
  }
}
