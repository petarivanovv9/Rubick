require "sinatra/activerecord"
require 'bcrypt'

class User < ActiveRecord::Base
  # validates_presence_of :email

  # validates :email, presence: true, uniqueness: {case_sensitive: false}
  validates :username, presence: true, uniqueness: {case_sensitive: false},length: {in: 2..60}
  validates :password, presence: true, length: {in: 5..60}
end