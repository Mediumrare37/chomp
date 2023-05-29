
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["spinner", "result"];
  connect(){
    console.log(
      'connected'
    );
  }
  insert() {
    console.log(
      'clicked'
    );
    this.element.innerHTML = "<i class='fa-solid fa-cog fa-spin'></i>";
  }
}
