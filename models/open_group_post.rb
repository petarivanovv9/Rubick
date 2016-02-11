require 'sinatra/activerecord'

class OpenGroupPost < ActiveRecord::Base
  validates :content, presence: true
  validates :user_id, presence: true
  validates :open_group_id, presence: true

  belongs_to :user
  belongs_to :open_group
end
