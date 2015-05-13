require File.expand_path('../environment.rb', __FILE__)

get '/' do
  erb :index
end

get '/auth/:provider/callback' do
  user = User.from_auth(auth_hash)
  user.save
  user.email
end

def auth_hash
  request.env['omniauth.auth']
end
