class User < ApplicationRecord
  validates :email, presence: true,
                    uniqueness: { case_sensitive: false },
                    format: { with: /\A[^@\s]+@[^@\s]+\z/, message: "must contain an @ character" }
end
