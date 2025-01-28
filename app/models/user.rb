class User < ApplicationRecord
  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true, confirmation: true, length: { minimum: 6 }

  def self.authenticate_with_credentials(email, password)
    normalized_email = email.strip.downcase
    user = User.find_by(email: normalized_email)
    user && user.authenticate(password) ? user : nil
  end
end
