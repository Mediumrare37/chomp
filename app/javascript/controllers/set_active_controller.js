import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="set-active"
export default class extends Controller {
  static targets = [ "list" ]
  connect() {
    const listItems = this.listTarget;
    console.log(listItems);
  }

  setActive() {
  }
}
