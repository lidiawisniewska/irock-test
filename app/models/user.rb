class User < ApplicationRecord
  normalizes :email, with: ->(email) { email.strip }

  validates :name, presence: true
  validates :email, presence: true,
                    uniqueness: { case_sensitive: false },
                    format: { with: /\A[^@\s]+@[^@\s]+\z/, message: "must contain an @ character" }
end
