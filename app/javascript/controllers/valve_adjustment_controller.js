import { Controller } from "@hotwired/stimulus"
import { Tooltip } from "bootstrap"

export default class extends Controller {
  static targets = [ "addShim", "pickShims", "completeAdjustment", "makeAdjustment" ]

  connect() {
    this.loadToolTips()
  }

  enableAdjustments() {
    this.addShimTarget.removeAttribute("disabled")
    this.pickShimsTarget.classList.remove("disabled")
    this.makeAdjustmentTarget.classList.add("d-none")
    this.completeAdjustmentTarget.classList.add("d-none")
  }

  loadToolTips() {
    let tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
    tooltipTriggerList.map(function (tooltipTriggerEl) {
      return new Tooltip(tooltipTriggerEl)
    })
  }
}