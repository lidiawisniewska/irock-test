import { Controller } from "@hotwired/stimulus"

// Validates the email field on the fly and toggles the submit button.
export default class extends Controller {
  static targets = ["email", "submit", "message"]

  connect() {
    this.touched = false
    this.validate()
  }

  validate(event) {
    // Reveal the message once the user leaves the field (blur).
    if (event && event.type === "blur") this.touched = true

    const value = this.emailTarget.value.trim()
    let error = null

    if (value === "") {
      error = "Please provide an email before submitting the form"
    } else if (!value.includes("@")) {
      error = "Please the email must have an @ character"
    }

    // Only surface the message once the user has touched the field,
    // so it doesn't appear on initial load.
    this.messageTarget.textContent = this.touched ? (error || "") : ""
    this.submitTarget.disabled = error !== null
  }
}
