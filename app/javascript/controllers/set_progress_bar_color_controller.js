import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="set-progress-bar-color"
export default class extends Controller {

  static targets = ['progressbar']

  connect() {
    console.log(this.progressbarTarget);
    console.log(getComputedStyle(this.progressbarTarget).getPropertyValue('--progress-percent'));
    this.setColor();
  }

  setColor() {
    const percentage = parseInt(getComputedStyle(this.progressbarTarget).getPropertyValue('--progress-percent'));
    if (percentage <= 25) {
      this.progressbarTarget.style.setProperty('--progress-color', 'red');
    } else if (percentage <= 50) {
      this.progressbarTarget.style.setProperty('--progress-color', 'orange');
    } else if (percentage <= 75) {
      this.progressbarTarget.style.setProperty('--progress-color', 'yellow');
    } else {
      this.progressbarTarget.style.setProperty('--progress-color', 'lime');
    }
  }
}
