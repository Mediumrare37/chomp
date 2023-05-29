import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="spinner"
export default class extends Controller {
  insert() {
    this.element.innerHTML=" <i class='fa-solid fa-cog fa-spin'></i>"
  }
}
