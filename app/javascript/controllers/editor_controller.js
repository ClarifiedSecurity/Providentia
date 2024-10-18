import { Controller } from "@hotwired/stimulus";
import throttle from "throttleit";

import { EditorView, keymap } from "@codemirror/view";
import { EditorState } from "@codemirror/state";
import { yaml } from "@codemirror/lang-yaml";
import { cobalt } from "thememirror";
import { defaultKeymap } from "@codemirror/commands";

export default class extends Controller {
  static values = {
    live: { type: Boolean, default: true },
  };

  editor;

  connect() {
    const textarea = this.element;
    const form = textarea.closest("form");
    let updatehandler;
    let throttled_submit;
    if (!textarea.readonly && !textarea.disabled) {
      throttled_submit = throttle(() => form.requestSubmit(), 500);
      updatehandler = EditorView.updateListener.of((v) => {
        if (v.docChanged) {
          textarea.value = v.state.doc.toString();
          this.liveValue && throttled_submit();
        }
      });
    }
    textarea.classList.add("hidden");
    const container = document.createElement("div");
    container.classList.add("bg-red-100", "w-full", "overflow-y-scroll");
    textarea.parentNode.appendChild(container);
    const state = EditorState.create({
      doc: textarea.value.toString(),
      extensions: [
        cobalt,
        yaml(),
        keymap.of(defaultKeymap),
        updatehandler,
      ].filter((obj) => obj),
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
