
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["form", "spinner","a","link"];

  insert() {
    this.element.innerHTML = "<i class='fa-solid fa-cog fa-spin'></i>";
  }
}
