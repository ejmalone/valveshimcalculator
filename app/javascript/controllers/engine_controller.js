import FormController from "./form_controller"

export default class extends FormController {
  static targets = [ "minintake", "maxintake", "minexhaust", "maxexhaust", "make", "model", "nickname", "error" ]
  static errorSelector = "input[data-engine-target].error"

  validate(event) {
    this.clearErrors(this.errorTarget, this.constructor.errorSelector)

    if (!this.makeTarget.value && !this.modelTarget.value) {
      if (!this.makeTarget.value) {
        this.makeTarget.classList.add("error")
      }

      if (!this.modelTarget.value) {
        this.modelTarget.classList.add("error")
      }

      this.addError(this.errorTarget, "Please enter a Make & Model for this engine")
    }

    if (!this.checkClearances(this.minintakeTarget.value, this.maxintakeTarget.value)) {
      [ this.minintakeTarget, this.maxintakeTarget ].forEach( (el) => el.classList.add("error") )
      this.addError(this.errorTarget, "Please enter a valid intake range")
    }

    if (!this.checkClearances(this.minexhaustTarget.value, this.maxexhaustTarget.value)) {
      [ this.minexhaustTarget, this.maxexhaustTarget ].forEach( (el) => el.classList.add("error") )
      this.addError(this.errorTarget, "Please enter a valid exhaust range")
    }

    super.validate(event)
  }

  checkClearances(min, max) {
    return !(min <= 0 || min >= 1 || max <= min || max >= 1)
  }
}
