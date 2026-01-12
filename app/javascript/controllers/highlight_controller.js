import { Controller } from "@hotwired/stimulus";

import { EditorView } from "@codemirror/view";
import { EditorState } from "@codemirror/state";
import { json } from "@codemirror/lang-json";
import { cobalt } from "thememirror";

export default class extends Controller {
  editor;

  connect() {
    const state = EditorState.create({
      doc: this.element.textContent,
      extensions: [
        EditorState.readOnly.of(true),
        EditorView.editable.of(false),
        EditorView.contentAttributes.of({ tabindex: "0" }),
        cobalt,
        json(),
      ].filter((obj) => obj),
    });

    this.element.textContent = "";

    this.editor = new EditorView({
      parent: this.element,
      state,
    });
  }

  disconnect() {
    this.editor.destroy();
  }
}
