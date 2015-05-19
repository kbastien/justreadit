require File.expand_path('../environment.rb', __FILE__)

get '/' do
  erb :index
end

get '/auth/:provider/callback' do
  if user = User.where(email: auth_hash[:uid]).first
    session[:user_id] = user.id
  else
    user = User.from_auth(auth_hash)
    user.save
    session[:user_id] = user.id
  end

  redirect '/'
end

get '/faq' do
  erb :faq
end

get '/settings' do
  erb :settings
end

get '/sign_out' do
  session[:user_id] = nil
  redirect '/'
end

def auth_hash
  request.env['omniauth.auth']
end

helpers do
  def current_user
    User.where(id: session[:user_id]).first
  end
end
