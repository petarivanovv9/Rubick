require "sinatra/activerecord"
require 'bcrypt'

class User < ActiveRecord::Base
  validates_presence_of :email

  EMAIL_REGEX = /[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}/i

  validates :email, :presence => true, :uniqueness => true, :format => EMAIL_REGEX
  validates :password, :confirmation => true
  validates_length_of :password, :in => 8..30, :on => :create

  before_save :encrypt_password
  def encrypt_password
      self.password = BCrypt::Password.create(password)
  end
end
