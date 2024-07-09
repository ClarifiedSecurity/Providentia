import { Controller } from "@hotwired/stimulus";
import throttle from "throttleit";

import { EditorView } from "@codemirror/view";
import { EditorState } from "@codemirror/state";
import { yaml } from "@codemirror/lang-yaml";
import { cobalt } from "thememirror";

export default class extends Controller {
  editor;

  connect() {
    const textarea = this.element;
    const form = textarea.closest("form");
    const throttled_submit = throttle(() => form.requestSubmit(), 500);
    textarea.classList.add("hidden");

    const container = document.createElement("div");
    container.classList.add("bg-red-100", "w-full", "overflow-y-scroll");
    textarea.parentNode.appendChild(container);
    const state = EditorState.create({
      doc: textarea.value.toString(),
      extensions: [
        cobalt,
        yaml(),
        EditorView.updateListener.of((v) => {
          if (v.docChanged) {
            textarea.value = v.state.doc.toString();
            throttled_submit();
          }
        }),
      ],
    });
    this.editor = new EditorView({
      parent: container,
      state,
    });
  }

  disconnect() {
    this.editor.destroy();
  }
}
