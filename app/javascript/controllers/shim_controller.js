import FormController from "./form_controller"

// TODO: replace a user-entered shim thickness of "x.yz" with "xyz"
export default class extends FormController {
  static targets = [ "thickness", "error", "accordion" ]
  static values = {
    min: Number,
    max: Number
  }
  static errorSelector = "input[data-shim-target].is-invalid"

  validate(event) {
    this.clearErrors(this.errorTarget, this.constructor.errorSelector)

    if (this.hasAccordionTarget) {
      this.removeAccordionErrors(this.accordionTarget)
    }

    this.thicknessTargets.forEach(shim => {
      let shimThickness = parseFloat(shim.value)

      if (!isNaN(shimThickness) && shimThickness < 10) {
        shimThickness *= 100
        shim.value = shimThickness
      }

      if (isNaN(shimThickness) || shimThickness <= this.minValue || shimThickness > this.maxValue) {
        shim.classList.add("is-invalid")

        if (this.hasAccordionTarget) {
          this.addErrorToAccordionHeader(shim)
        }
      }
    })

    if (document.querySelectorAll(this.constructor.errorSelector).length > 0) {
      this.addError(this.errorTarget, "Please enter a valid shim size (" + this.minValue + " - " + this.maxValue + ")")
    }

    super.validate(event)
  }
}
