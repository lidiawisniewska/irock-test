require "test_helper"

class SignUpsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test "should get new" do
    get new_sign_up_url
    assert_response :success
  end

  test "root path shows the sign up page" do
    get root_url
    assert_response :success
  end

  test "should get thank you" do
    get thank_you_url
    assert_response :success
  end

  test "signs up a new email and redirects to thank you" do
    assert_difference("User.count", 1) do
      post sign_up_url, params: { user: { email: "newcomer@example.com", name: "New Comer" } }
    end

    assert_redirected_to thank_you_path
    assert_equal "newcomer@example.com", User.last.email
    assert_equal "New Comer", User.last.name
  end

  test "duplicate email is not added again but still redirects to thank you" do
    assert_no_difference("User.count") do
      post sign_up_url, params: { user: { email: @user.email, name: "Someone Else" } }
    end

    assert_redirected_to thank_you_path
  end

  test "duplicate email is matched case-insensitively" do
    assert_no_difference("User.count") do
      post sign_up_url, params: { user: { email: @user.email.upcase, name: "Someone Else" } }
    end

    assert_redirected_to thank_you_path
  end

  test "email with surrounding whitespace still dedupes" do
    assert_no_difference("User.count") do
      post sign_up_url, params: { user: { email: "  #{@user.email}  ", name: "Spaced" } }
    end

    assert_redirected_to thank_you_path
  end

  test "blank email re-renders the form and creates nothing" do
    assert_no_difference("User.count") do
      post sign_up_url, params: { user: { email: "", name: "No Email" } }
    end

    assert_response :unprocessable_content
  end

  test "malformed email re-renders the form and creates nothing" do
    assert_no_difference("User.count") do
      post sign_up_url, params: { user: { email: "not-an-email", name: "Bad Email" } }
    end

    assert_response :unprocessable_content
  end
end
