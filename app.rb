require 'sinatra'
require 'sinatra/base'
require "./controller"
require "./helpers"

class App < Sinatra::Base
  set :app_file, __FILE__
end
