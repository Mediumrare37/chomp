import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="expand-card"
export default class extends Controller {
  static targets = [ "chasks" ]

  connect() {
    console.log(this.chasksTarget);
  }

  displayChasks() {
    this.chasksTarget.classList.toggle('expanded');

    if (!this.chasksTarget.classList.contains('expanded')) this.chasksTarget.classList.toggle('collapsed');
    else if (this.chasksTarget.classList.contains('expanded') && this.chasksTarget.classList.contains('collpsed')) this.chasksTarget.classList.toggle('collapsed');
  }
}
