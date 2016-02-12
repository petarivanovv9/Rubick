class OpenGroupPostComment < ActiveRecord::Base
  validates :content, presence: true
  validates :user_id, presence: true
  validates :open_group_post_id, presence: true

  belongs_to :user
  belongs_to :open_group_post
end
