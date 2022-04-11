import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "mileage", "error" ]

  validate(event) {
    this.errorTarget.innerHTML = ""

    if (this.mileageTarget.value <= 0) {
      this.errorTarget.innerHTML = "Please enter a valid mileage"
      event.preventDefault()
    }
  }
}
