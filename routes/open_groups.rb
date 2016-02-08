class App < Sinatra::Base

  get '/create_open_group' do
    if logged_in?
      erb :create_open_group
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
