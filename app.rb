require 'sinatra'
require_relative 'pizza.rb'

get '/' do
    erb :home
end

post '/home' do
    size = params[size]
    meats = params[meat].join(",")
    veg = params[veggies].join(",")
    extras = params[extras].join(",")
    redirect 'checkselected?size=' + size + '&meat=' + meat + '&veggies=' + veg + '&extras=' + extras
end

get '/checkselected' do
    size = params[size]
    meats = params[meat].split(",")
    veg = params[veggies].split(",")
    extras = params[extras].split(",")
    erb :lastname, locals: {size: size, meats: meats, veg: veg, extras: extras}
end