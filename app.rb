require 'sinatra'
require File.expand_path('../environment.rb', __FILE__)

get '/' do
  erb :index
end
