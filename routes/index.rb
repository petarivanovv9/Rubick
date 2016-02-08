class App < Sinatra::Base
  get '/' do
    if session.has_key?(:username) and session.has_key?(:user_id)
      @username = session[:username]
      @user_open_groups = UserOpenGroup.where(user_id: session[:user_id])
      @user_open_groups_names = Array.new
      @user_open_groups.each do |group|
        group_name = OpenGroup.find(group.open_group_id).name
        @user_open_groups_names << group_name
      end
    else
      @username = ""
      @user_open_groups_names = []
    end

    erb :index
  end
end
