import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="set-active-navlink"
export default class extends Controller {

  static targets = [ 'link' ]

  connect() {
    this.createTargets();
    this.checkActive();
  }

  createTargets() {
    const links = document.querySelectorAll('a');
    links.forEach((link) => {
      link.setAttribute('data-set-active-navlink-target', 'link');
    });
  }

  checkActive() {
    this.linkTargets.forEach((e) => {
      if(e.href === window.location.href) {
        e.classList.add('active');
      }
    })
  }

}
