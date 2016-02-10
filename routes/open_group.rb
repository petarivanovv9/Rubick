class App < Sinatra::Base

  get '/create_open_group' do
    if logged_in?
      erb :create_open_group
    else
      redirect to('/')
    end
  end

  get '/open_group/:name' do
    # I can make some function to check
    # is the user has the permission to view the page

    if logged_in?
      # @group_name = params[:name]
      @open_group = OpenGroup.where(name: params[:name]).take
      admin_id = UserOpenGroup.where(open_group_id: @open_group.id).take.user_id
      @group_admin = User.find(admin_id).username

      @has_joined = joined_open_group?(session[:user_id], @open_group.id)

      erb :show_open_group
    else
      redirect to('/')
    end
  end

  def joined_open_group?(user_id, open_group_id)
    has_joined = UserOpenGroup.where(
      user_id: user_id,
      open_group_id: open_group_id
      )

    not has_joined.empty?
  end

  post '/leave_open_group/:name' do
    if logged_in?
      redirect "/open_group/#{params[:name]}"
    else
      redirect to('/')
    end
  end

  post '/join_open_group/:name' do
    if logged_in?
      @open_group = OpenGroup.where(name: params[:name]).take
      has_joined = joined_open_group?(session[:user_id], @open_group.id)

      if not has_joined
        user_join = UserOpenGroup.create
        user_join.user_id = session[:user_id]
        user_join.open_group_id = @open_group.id
        user_join.save
      end

      redirect "/open_group/#{params[:name]}"
    else
      redirect to('/')
    end
  end

  post '/create_open_group' do
    redirect to('/') if not logged_in?

    @open_group = OpenGroup.create(
      name: params[:open_group_name],
      description: params[:open_group_description])

    if @open_group.valid?
      user_join = UserOpenGroup.create
      user_join.user_id = session[:user_id]
      user_join.open_group_id = @open_group.id
      user_join.save

      redirect to('/')
    else
      puts "Error with open group creation."
      erb :create_open_group
    end
  end
end
