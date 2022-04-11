import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "thickness", "error" ]
  static values = {
    min: Number,
    max: Number
  }
  static errorSelector = "input[data-shim-target].error"

  validate(event) {
    this.errorTarget.innerHTML = ""
    document.querySelectorAll(this.constructor.errorSelector).forEach(shim => shim.classList.remove("error"))

    this.thicknessTargets.forEach(shim => {
      if (shim.value <= this.minValue || shim.value > this.maxValue) {
        shim.classList.add("error")
      }
    })

    if (document.querySelectorAll(this.constructor.errorSelector).length > 0) {
      this.errorTarget.innerHTML = "Please enter a valid shim thickness (" + this.minValue + " - " + this.maxValue + ")"
      event.preventDefault()
    }
  }
}
