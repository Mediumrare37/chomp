import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="expand-card"
export default class extends Controller {
  static targets = [ "chasks", "icon" ]

  connect() {
    console.log(this.chasksTarget);
    console.log(this.iconTarget);
  }

  displayChasks() {
    this.chasksTarget.classList.toggle('expanded');

    if (!this.chasksTarget.classList.contains('expanded')) {
      this.chasksTarget.classList.toggle('collapsed');
    } else if (this.chasksTarget.classList.contains('expanded') && this.chasksTarget.classList.contains('collapsed')) {
      this.chasksTarget.classList.toggle('collapsed');
    }

    this.iconTarget.classList.toggle('rotated');

    if (!this.iconTarget.classList.contains('rotated')) {
      this.iconTarget.classList.toggle('unrotated');
    } else if (this.iconTarget.classList.contains('rotated') && this.iconTarget.classList.contains('unrotated')) {
      this.iconTarget.classList.toggle('unrotated');
    }
  }
}
