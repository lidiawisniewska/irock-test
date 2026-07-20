require "application_system_test_case"

class SignUpsTest < ApplicationSystemTestCase
  test "visitor joins the waiting list" do
    visit root_path

    assert_selector "h1.waitlist__title", text: "Coming soon"

    fill_in "Your email", with: "newcomer@example.com"
    fill_in "Your name", with: "New Comer"
    click_on "Join the waiting list"

    assert_selector "h1.thank-you", text: "Thank you"
    assert_equal 1, User.where(email: "newcomer@example.com").count
  end

  test "client-side validation blocks submitting an email without an @" do
    visit root_path

    # The submit button is disabled until a well-formed email is entered.
    fill_in "Your email", with: "not-an-email"
    fill_in "Your name", with: "Bad Email"

    assert_button "Join the waiting list", disabled: true
    assert_no_difference -> { User.count } do
      # Leaving the field surfaces the inline error message.
      find_field("Your name").click
      assert_selector ".field__error", text: "@"
    end
  end
end
