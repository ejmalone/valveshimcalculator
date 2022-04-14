import FormController from "./form_controller"

export default class extends FormController {
  static targets = [ "mileage", "error" ]
  static errorSelector = "input[data-new-valve-adjustment-target].error"

  validate(event) {
    this.clearErrors(this.errorTarget, this.constructor.errorSelector)

    if (this.mileageTarget.value <= 0) {
      this.mileageTarget.classList.add("error")
      this.addError(this.errorTarget, "Please enter a valid mileage")
    }

    super.validate(event)
  }
}
