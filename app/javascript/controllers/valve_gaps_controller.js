import FormController from "./form_controller"

export default class extends FormController {
  static targets = [ "gap", "error" ]
  static errorSelector = "input[data-valve-gaps-target].error"

  validate(event) {
    this.clearErrors(this.errorTarget, this.constructor.errorSelector)

    this.gapTargets.forEach(gap => {
      if (gap.value <= 0 || gap.value >= 1) {
        gap.classList.add("error")
      }
    })

    if (document.querySelectorAll(this.constructor.errorSelector).length > 0) {
      this.addError(this.errorTarget, "Please enter a valid gap (e.g. 0.15)")
    }

    super.validate(event)
  }
}
