class App < Sinatra::Base
  get '/' do
    if session.has_key?(:username)
      @username = session[:username]
    else
      @username = ""
    end

    erb :index
  end
end
