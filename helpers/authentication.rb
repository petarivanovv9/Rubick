module AuthenticationHelper
  def logged_in?
    session.has_key?(:user_id)
  end

  def login(username, password)
    if not logged_in?
      user = User.find_by(username: params[:username])

      if user and user.password == password
        create_logged_in_session(user.id, user.username)
        user
      end
    end
  end

  def register(username, password)
    user = User.create(username: username, password: password)

    create_logged_in_session(user.id, user.username) if user.valid?

    user
  end

  def logout
    delete_logged_in_session() if logged_in?
  end

  private

  def create_logged_in_session(user_id, username)
    session[:user_id] = user_id
    session[:username] = username
  end

  def delete_logged_in_session
    session.delete(:user_id)
    session.delete(:username)
  end
end
