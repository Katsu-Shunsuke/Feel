require 'bundler'
Bundler.require

require './app'
run Sinatra::Application

require 'gon-sinatra'
Sinatra::register Gon::Sinatra