require 'sinatra'
require "sinatra/reloader"

# Run this script with `bundle exec ruby app.rb`
require 'sqlite3'
require 'active_record'

#require model classes
# require './models/cake.rb'
require './models/user.rb'
require './models/post.rb'

# Use `binding.pry` anywhere in this script for easy debugging
require 'pry'
require 'csv'

# Connect to a sqlite3 database
# If you feel like you need to reset it, simply delete the file sqlite makes
ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: 'db/development.db'
)

register Sinatra::Reloader
enable :sessions

get '/' do
  erb :sign_up
end

get '/homepage' do
  erb :homepage
end

post '/sign_up' do
  new_user = User.create(first_name: params["first_name"], last_name: params["last_name"], email: params["email"], birthday: params["birthday"], password: ["password"])

  session[:user_id] = new_user.id
  redirect '/homepage'
end

post '/login' do
  known_user = User.find_by(email: params["email"], password: paramsUser"password"])
  if known_user
    session[:user_id] = known_user.id
    redirect '/homepage'
  else 
    redirect '/'
  end
end
