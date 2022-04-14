import FormController from "./form_controller"

export default class extends FormController {
  static targets = [ "thickness", "error" ]
  static values = {
    min: Number,
    max: Number
  }
  static errorSelector = "input[data-shim-target].error"

  validate(event) {
    this.clearErrors(this.errorTarget, this.constructor.errorSelector)

    this.thicknessTargets.forEach(shim => {
      if (shim.value <= this.minValue || shim.value > this.maxValue) {
        shim.classList.add("error")
      }
    })

    if (document.querySelectorAll(this.constructor.errorSelector).length > 0) {
      this.addError(this.errorTarget, "Please enter a valid shim thickness (" + this.minValue + " - " + this.maxValue + ")")
    }

    super.validate(event)
  }
}
