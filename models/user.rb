require 'bcrypt'

class User < ActiveRecord::Base
  validates :username, presence: true, uniqueness: {case_sensitive: false},length: {in: 2..60}, format: { with: /\A[a-z0-9]+\z/ }
  validates :password, presence: true, length: {in: 5..60}

  has_many :user_open_groups
  has_many :open_group_post_comments

  include BCrypt

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end
end
