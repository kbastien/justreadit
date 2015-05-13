require 'sequel'
require 'dotenv'
require 'omniauth'
require 'omniauth-pocket'
require 'sinatra'
require 'sinatra/sequel'
require 'pry'

Dotenv.load! unless ENV['RACK_ENV'] == 'production'

puts 'Setting up database...'
set :database, 'postgres://localhost/justreadit_development'

Sequel::Model.plugin :timestamps

# Pull in the models...
require File.expand_path('../models/user.rb', __FILE__)

migration 'add users table' do
  database.create_table :users do
    primary_key :id
    String      :name
    String      :email
    String      :stripe_customer_id
    String      :pocket_token
    DateTime    :created_at
    DateTime    :updated_at
  end
end

use Rack::Session::Cookie
use OmniAuth::Builder do
  provider :pocket, ENV['POCKET_KEY']
end
