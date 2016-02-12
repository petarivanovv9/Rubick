module OpenGroupHelper
  def joined_open_group?(user_id, open_group_id)
    has_joined = UserOpenGroup.where(
      user_id: user_id,
      open_group_id: open_group_id
      )

    not has_joined.empty?
  end

  def get_open_group(name)
    OpenGroup.where(name: name)
  end

  def join_user_to_open_group(user_id, open_group_id)
    user_join = UserOpenGroup.create
    user_join.user_id = user_id
    user_join.open_group_id = open_group_id
    user_join.save
  end

  def get_open_group_admin_id(open_group_id)
    UserOpenGroup.where(open_group_id: open_group_id).take.user_id
  end

  def create_open_group_post(user_id, open_group_id, content)
    open_group_post = OpenGroupPost.create
    open_group_post.user_id = user_id
    open_group_post.open_group_id = open_group_id
    open_group_post.content = content
    open_group_post.save
  end

  def delete_user_open_group_relations(user_id, open_group_id)
    UserOpenGroup.where(
      user_id: user_id,
      open_group_id: open_group_id
    ).destroy_all
  end

  def create_open_group_post_comment(user_id, open_group_post_id, content)
    open_group_post_comment = OpenGroupPostComment.create
    open_group_post_comment.user_id = user_id
    open_group_post_comment.open_group_post_id = open_group_post_id
    open_group_post_comment.content = content
    open_group_post_comment.save
  end
end
