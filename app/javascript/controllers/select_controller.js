import { Controller } from "@hotwired/stimulus";
import TomSelect from "tom-select";

export default class extends Controller {
  instance;

  static values = {
    options: { type: Array, default: [] },
  };

  connect() {
    if (!this.element.hidden) {
      // set manually if inherited from another element, tomselect only looks at current element attribute
      this.element.disabled = this.element.matches(":disabled");
      let options;
      if (this.element.dataset.create) {
        options = {
          wrapperClass: "ts-wrapper form-input",
          disabled: this.element.disabled,
          createOnBlur: true,
          create: true,
        };
      } else {
        const hasEmptyOption =
          this.element.querySelectorAll("option[value='']").length > 0;
        const ismultiple = this.element.multiple;
        options = {
          allowEmptyOption: hasEmptyOption,
          maxOptions: null,
          wrapperClass: "ts-wrapper form-input",
          onDelete: function (values, event) {
            return ismultiple || !(values.length == 1 && !hasEmptyOption);
          },
          onChange: function () {
            document.activeElement.blur();
          }.bind(this),
        };
      }
      this.instance = new TomSelect(this.element, options);
      this.instance.addOptions(
        this.optionsValue.map((tag) => {
          return { text: tag, value: tag };
        })
      );
    }
  }

  disconnect() {
    this.instance.destroy();
  }
}
