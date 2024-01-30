import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static values = {
    isDark: { type: Boolean },
  };
  static targets = ["input"];

  connect() {
    this.isDarkValue = document.documentElement.classList.contains("dark");
    this.setInputState();
  }

  setInputState() {
    this.inputTarget.checked = this.isDarkValue;
    document.documentElement.classList.toggle("dark", this.isDarkValue);
  }

  flipMode() {
    this.isDarkValue = !this.isDarkValue;
    localStorage.theme = this.isDarkValue ? "dark" : "light";
    this.setInputState();
  }
}
