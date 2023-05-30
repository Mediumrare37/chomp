
import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="spinner"
export default class extends Controller {
  static targets = ["form", "spinner","a","link"];

  insert() {
    this.element.innerHTML=" <i class='fa-solid fa-cog fa-spin'></i>"
  }
}
