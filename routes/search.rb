class App < Sinatra::Base

  include AuthenticationHelper

  include HaltHelper

  get '/search'  do
    erb '/search'
  end

  post '/search' do
    if logged_in?
      @result = OpenGroup.where("name LIKE :search", search: "%#{params[:search]}%")

      puts @result.size

      erb :'search'
    else
      halt_with_message(404, "You don't have a permission.")
    end
  end
end
