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
    console.log(percentage);
  }
}
