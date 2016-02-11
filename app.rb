require 'sinatra/base'
require 'bundler/setup'
require 'sinatra/activerecord'


require_relative 'helpers/init'
require_relative 'routes/init'
require_relative 'models/init'


class App < Sinatra::Base
  enable :sessions

  set :app_file, __FILE__
end
