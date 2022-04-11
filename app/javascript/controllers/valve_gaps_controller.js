import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "gap", "error" ]
  static errorSelector = "input[data-valve-gaps-target].error"

  validate(event) {
    this.errorTarget.innerHTML = ""
    document.querySelectorAll(this.constructor.errorSelector).forEach(gap => gap.classList.remove("error"))

    this.gapTargets.forEach(gap => {
      if (gap.value <= 0 || gap.value >= 1) {
        gap.classList.add("error")
      }
    })

    if (document.querySelectorAll(this.constructor.errorSelector).length > 0) {
      this.errorTarget.innerHTML = "Please enter a valid gap (e.g. 0.15)"
      event.preventDefault()
    }
  }
}
