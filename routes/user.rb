class App < Sinatra::Base
  get '/login' do
    erb :'login'
  end
end
