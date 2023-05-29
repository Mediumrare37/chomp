
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["spinner", "result", "overlay", "theSpinner"];
  connect(){
    console.log(
      'connected'
    );
  }
  insert() {
    console.log(
      'clicked'
    );
    this.theSpinnerTarget.innerHTML = "<i class='fa-solid fa-cog fa-spin'></i>";
    this.overlayTarget.style.display = "block";
  }
}
