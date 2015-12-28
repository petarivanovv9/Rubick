# config.ru (run with rackup)
# type: rackup -p 4567

require File.join(File.dirname(__FILE__), 'app.rb')

run App.new
