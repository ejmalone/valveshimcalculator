import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "error" ]
  errors = []

  clearErrors(container, elementSelector) {
    container.innerHTML = ""
    document.querySelectorAll(elementSelector).forEach(field => field.classList.remove("is-invalid"))
    this.errors = []

    let outerError = container.parentNode

    if (!this.anyErrorPresent(outerError)) {
      outerError.classList.add("d-none")
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

    container.parentNode.classList.remove("d-none")
  }

  validate(event) {
    if (this.errors.length > 0) {
      event.preventDefault()
    }
  }

  // given an element in an accordion, add an error class to its header
  addErrorToAccordionHeader(element) {
    while(element && !element.matches(".accordion-item")) {
      element = element.parentElement;
    }

    if (element) {
      element.querySelector(".accordion-header").classList.add("is-invalid")
    }
  }

  removeAccordionErrors(accordion) {
    accordion.querySelectorAll(".accordion-header.is-invalid").forEach(field => field.classList.remove("is-invalid"))
  }

  anyErrorPresent(formErrorsEl) {
    return Array.from(formErrorsEl.querySelectorAll(".form_error")).some(el => el.innerHTML)
  }
}
