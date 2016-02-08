class App < Sinatra::Base
  get '/login' do
    erb :'login'
  end

  get '/register' do
    erb :'register'
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
end
