class UserOpenGroup < ActiveRecord::Base
  validates :user_id, presence: true
  validates :open_group_id, presence: true

  belongs_to :open_group
  belongs_to :user
end
