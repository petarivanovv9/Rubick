require 'sinatra/base'
require 'sinatra-contrib'
require 'sinatra/activerecord'

require_relative 'helpers/init'
require_relative 'routes/init'
require_relative 'models/init'

class App < Sinatra::Base
  set :app_file, __FILE__
end
