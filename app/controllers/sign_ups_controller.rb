class SignUpsController < ApplicationController
  # GET / and /sign_up/new
  def new
    @user = User.new
  end

  # POST /sign_up
  def create
    @user = User.new(sign_up_params)

    if @user.save
      redirect_to thank_you_path
    elsif already_on_waiting_list?(@user)
      # Email is already on the list: don't add a duplicate row, but the
      # visitor has effectively succeeded, so send them to the thank-you page.
      redirect_to thank_you_path
    else
      render :new, status: :unprocessable_content
    end
  rescue ActiveRecord::RecordNotUnique
    # A concurrent request inserted the same email between our validation
    # and the INSERT; treat it as already signed up.
    redirect_to thank_you_path
  end

  # GET /thank_you
  def thank_you
  end

  private
    # True when the *only* reason the record is invalid is that the email is
    # already taken — i.e. the email itself is well-formed, just a repeat.
    def already_on_waiting_list?(user)
      user.errors.of_kind?(:email, :taken) && user.errors.attribute_names == [:email]
    end

    # Only allow a list of trusted parameters through.
    def sign_up_params
      params.expect(user: [ :name, :email ])
    end
end
