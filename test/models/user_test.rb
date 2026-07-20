require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "is valid with a name and a well-formed email" do
    assert User.new(name: "Carol", email: "carol@example.com").valid?
  end

  test "is invalid without a name" do
    user = User.new(name: "", email: "carol@example.com")
    assert_not user.valid?
    assert_includes user.errors[:name], "can't be blank"
  end

  test "is invalid without an email" do
    user = User.new(name: "Carol", email: "")
    assert_not user.valid?
    assert_includes user.errors[:email], "can't be blank"
  end

  test "is invalid when the email has no @ character" do
    user = User.new(name: "Carol", email: "carol.example.com")
    assert_not user.valid?
    assert_includes user.errors[:email], "must contain an @ character"
  end

  test "is invalid with a duplicate email" do
    duplicate = User.new(name: "Not Alice", email: users(:one).email)
    assert_not duplicate.valid?
    assert_includes duplicate.errors[:email], "has already been taken"
  end

  test "treats email uniqueness as case-insensitive" do
    duplicate = User.new(name: "Not Alice", email: users(:one).email.upcase)
    assert_not duplicate.valid?
    assert_includes duplicate.errors[:email], "has already been taken"
  end

  test "strips leading and trailing whitespace from the email" do
    user = User.new(name: "Carol", email: "  carol@example.com  ")
    assert_equal "carol@example.com", user.email
  end

  test "downcases the email so uniqueness holds at the database level" do
    user = User.new(name: "Carol", email: "Carol@Example.COM")
    assert_equal "carol@example.com", user.email
  end

  test "a padded email still collides with an existing record" do
    duplicate = User.new(name: "Not Alice", email: "  #{users(:one).email}  ")
    assert_not duplicate.valid?
    assert_includes duplicate.errors[:email], "has already been taken"
  end
end
