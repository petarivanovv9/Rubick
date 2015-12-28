# require 'sinatra'
require 'sinatra/base'

require_relative 'helpers/init'
require_relative 'routes/init'

class App < Sinatra::Base
  set :app_file, __FILE__
end
