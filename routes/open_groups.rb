class App < Sinatra::Base
  get '/create_open_group' do
    if logged_in?
      erb :create_open_group
    else
      redirect to('/')
    end
  end
end
