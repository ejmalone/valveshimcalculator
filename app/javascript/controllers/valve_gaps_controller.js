import FormController from "./form_controller"

export default class extends FormController {
  static targets = [ "gap", "error", "accordion" ]
  static errorSelector = "input[data-valve-gaps-target].is-invalid"

  validate(event) {
    this.clearErrors(this.errorTarget, this.constructor.errorSelector)
    this.removeAccordionErrors(this.accordionTarget)

    this.gapTargets.forEach(gap => {
      if (gap.value <= 0 || gap.value >= 1) {
        gap.classList.add("is-invalid")
        this.addErrorToAccordionHeader(gap)
      }
    })

    if (document.querySelectorAll(this.constructor.errorSelector).length > 0) {
      this.addError(this.errorTarget, "Please enter a valid gap (e.g. 0.15)")
    }

    super.validate(event)
  }
}
