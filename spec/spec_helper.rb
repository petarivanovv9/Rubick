ENV['RACK_ENV'] = 'test'

require_relative '../app.rb'

require 'rspec'
require 'capybara/rspec'

Capybara.app = App
