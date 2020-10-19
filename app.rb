require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?

require './models'
require 'dotenv/load'

enable :sessions

helpers do
  def current_user
    User.find_by(id: session[:user])
  end
end


get '/' do
  @posts=Post.all
  @users=User.all
  erb :main
end

get '/signin' do
  erb :signin
end

post '/signin' do
  user = User.find_by(name: params[:name])
  if user && user.authenticate(params[:password])
    session[:user] = user.id
  end
  redirect '/'
end

get '/signup' do
  erb :signup
end

post '/signup' do
  @user=User.create({
    name:params[:name],
    password:params[:password],
    password_confirmation:params[:password_confirmation]
  })
  if @user.persisted?
    session[:user]=@user.id
  end
  redirect '/'
end

get '/signout' do
  session[:user]=nil
  redirect '/'
end

get '/new' do
  @questions1=["happy","sad","angry","worried","emotionless"]
  @questions2=["fine","hungey","thirsty","sleepy","tired"]
  @questions3=["sunny","cloudy","rainy","snowy","windy"]
  erb :new
end

post '/new' do
  Post.create({
    user_id:current_user.id,
    option1:params[:question1],
    option2:params[:question2],
    option3:params[:question3]
  })
  redirect '/'
end

get '/home/:id' do
  @posts_user=Post.where(user_id: params[:id])
  @user=User.find_by(id: params[:id])
  @property=Property.find_by(user_id: current_user)
  erb :home
end

get '/follow' do
  erb :follow
end

get '/follow/:id' do
  Follow.create({
    follow_id:current_user.id,
    opponent_id:params[:id]
  })
  redirect '/follow'
end

get '/remove/:id' do
  follow=Follow.find_by(follow_id:current_user.id, opponent_id:params[:id])
  follow.delete
  redirect '/follow'
end

get '/property' do
  @property=Property.find_by(user_id:current_user.id)
  @user=current_user
  erb :property
end

post '/property/new' do
  Property.create({
    user_id:current_user.id,
    favorite1:params[:radio1],
    favorite2:params[:radio2]
  })
  redirect '/'
end

post '/property/edit' do
  property=Property.find_by(user_id:current_user.id)
  property.favorite1=params[:radio1]
  property.favorite2=params[:radio2]
  property.save!
  redirect '/'
end

get '/explain' do
  erb :explain
end