class User < ActiveRecord::Base
  has_many :ideas
  validates :first_name, :last_name, :password, presence: true
  validates :email, presence: true, uniqueness: true

  has_secure_password

  enum role: %w(default, admin)

  def admin?
    role == 'admin'
  end
end
