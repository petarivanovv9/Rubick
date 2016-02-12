class OpenGroupPost < ActiveRecord::Base
  validates :content, presence: true
  validates :user_id, presence: true
  validates :open_group_id, presence: true

  belongs_to :user
  belongs_to :open_group

  has_many :open_group_post_comments
end
