class App < Sinatra::Base
  get '/login' do
    erb :'login'
  end

  get '/register' do
    erb :'register'
  end
end
