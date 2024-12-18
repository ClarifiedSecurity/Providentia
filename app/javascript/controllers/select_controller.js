import { Controller } from "@hotwired/stimulus";
import TomSelect from "tom-select";

export default class extends Controller {
  instance;
  settings;

  static values = {
    options: { type: Array, default: [] },
  };

  connect() {
    if (!this.element.hidden) {
      // set manually if inherited from another element, tomselect only looks at current element attribute
      this.element.disabled = this.element.matches(":disabled");

      if (this.element.dataset.create) {
        this.settings = {
          wrapperClass: "ts-wrapper form-input",
          disabled: this.element.disabled,
          createOnBlur: true,
          create: true,
          searchField: ["text", "terms"],
        };
      } else {
        const hasEmptyOption =
          this.element.querySelectorAll("option[value='']").length > 0;
        this.settings = {
          allowEmptyOption: hasEmptyOption,
          maxOptions: null,
          wrapperClass: "ts-wrapper form-input",
          searchField: ["text", "terms"],
          onDelete: function (values, event) {
            return (
              this.element.multiple || !(values.length == 1 && !hasEmptyOption)
            );
          }.bind(this),
          onChange: function () {
            document.activeElement.blur();
          }.bind(this),
        };
      }
      this.instance = new TomSelect(this.element, this.settings);
      this.instance.addOptions(
        this.optionsValue.map((tag) => {
          return { text: tag, value: tag };
        })
      );

      Object.values(this.instance.options).forEach((option) => {
        if (option["$option"] && option["$option"].dataset.terms) {
          this.instance.updateOption(option.value, {
            value: option.value,
            text: option.text,
            optgroup: option.optgroup,
            terms: JSON.parse(option["$option"].dataset.terms).join(""),
          });
        }
      });
    }
  }

  disconnect() {
    this.instance.destroy();
  }
}
