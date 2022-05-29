import { Controller } from "@hotwired/stimulus"
import { Popover } from "bootstrap"

export default class extends Controller {
  static targets = [ "token", "button" ]
  connect() {
    if (navigator.clipboard) {
      this.buttonTarget.classList.remove("d-none")
    }
  }

  copy() {
    this.tokenTarget.select();

    navigator.clipboard.writeText(this.tokenTarget.value);

    let pop = new Popover(this.buttonTarget, {content: "Copied", placement: "bottom", trigger: "focus"})

    this.buttonTarget.addEventListener('shown.bs.popover', () => {
      setTimeout(() => pop.hide(), 1000)
    })

    pop.show()
  }
}
