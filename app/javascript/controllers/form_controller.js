import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "error" ]
  errors = []

  clearErrors(container, elementSelector) {
    container.innerHTML = ""
    document.querySelectorAll(elementSelector).forEach(field => field.classList.remove("error"))
    this.errors = []

    let outerError = container.parentNode

    if (!this.anyErrorPresent(outerError)) {
      outerError.classList.remove("populated")
    }
  }

  addError(container, message) {
    this.errors.push(message)

    if (container.innerHTML) {
      container.innerHTML += "<br>" + message;
    }
    else {
      container.innerHTML = message;
    }

    container.parentNode.classList.add("populated")
  }

  validate(event) {
    if (this.errors.length > 0) {
      event.preventDefault()
    }
  }

  anyErrorPresent(formErrorsEl) {
    return Array.from(formErrorsEl.querySelectorAll(".form_error")).some(el => el.innerHTML)
  }
}