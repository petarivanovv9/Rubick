require 'sinatra/activerecord/rake'
require 'rspec/core/rake_task'

namespace :db do
  task :load_config do
    require './app'
  end
end

task :spec do
  system 'rspec --color --format documentation'
end
