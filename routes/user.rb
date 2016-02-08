class App < Sinatra::Base
  get '/login' do
    if logged_in?
      redirect to('/')
    else
      erb :'login'
    end
  end

  get '/register' do
    if logged_in?
      redirect to('/')
    else
      erb :'register'
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

  include AuthenticationHelper

  post '/register' do
    redirect to('/') if logged_in?

    redirect to('/') if params[:password] != params[:password2]

    @user = register(params[:username], params[:password])

    # here i can halt some message!!!
    if @user.valid?
      redirect to('/')
    else
      erb :'register'
    end
  end

  post '/login' do
    redirect to('/') if logged_in?

    @user = login(params[:username], params[:password])

    if @user
      redirect to('/')
    else
      erb :'login'
    end
  end
end
