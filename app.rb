require 'sinatra'
require_relative 'pizza.rb'

get '/' do
    erb :home
end