class App < Sinatra::Base

  include AuthenticationHelper

  get '/login' do
    if logged_in?
      redirect to('/')
    else
      erb :'auth/login'
    end
  end

  get '/register' do
    if logged_in?
      redirect to('/')
    else
      erb :'auth/register'
    end
  end

  get '/logout' do
    if logged_in?
      logout
      redirect to('/')
    else
      redirect to('/')
    end
  end

  post '/register' do
    redirect to('/') if logged_in?

    redirect to('/register') if params[:password] != params[:password2]
    redirect to('/register') if params[:password].size <= 4

    # if params[:password] != params[:password2]
    #   halt status, { message: "Wrong passwords!" }.to_json
    # end

    @user = register(params[:username], params[:password])

    # here i can halt some message!!!
    if @user.valid?
      redirect to('/')
    else
      erb :'auth/register'
    end
  end

  post '/login' do
    redirect to('/') if logged_in?

    @user = login(params[:username], params[:password])

    if @user
      redirect to('/')
    else
      erb :'auth/login'
    end
  end

  get '/user/:username' do
    if logged_in?
      @user = User.where(username: params[:username]).take

      erb :'users/show'
    else
      redirect to('/')
    end
  end

  get '/user/:username/edit' do
    if logged_in?
      @user = User.where(username: params[:username]).take

      if @user.id == session[:user_id]
        erb :'users/edit'
      else
        redirect to('/')
      end
    else
      redirect to('/')
    end
  end

  post '/user/:username/update' do
    if logged_in?
      @user = User.where(username: params[:username]).take

      if equal_passwords?(@user.password, params[:old_password]) and equal_passwords?(params[:new_password], params[:new_password2])

        @user.update(password: params[:new_password])

        redirect to ('/')
      else
        erb :'users/edit'
      end
    else
      redirect to('/')
    end
  end
end
