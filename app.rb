require 'sinatra'

get '/' do
    erb :home
end

post '/home' do
    size = params[:size]
    crust = params[:crust]
    meats = params[:meat].join(",")
    veg = params[:veggies].join(",")
    extras = params[:extras].join(",")
    delivery = params[:delivery]
    redirect 'checkselected?size=' + size + '&crust=' + crust + '&meat=' + meats + '&veggies=' + veg + '&extras=' + extras + '&delivery=' + delivery
end

get '/checkselected' do
    size = params[:size]
    crust = params[:crust]
    meats = params[:meat].split(",")
    veg = params[:veggies].split(",")
    extras = params[:extras].split(",")
    delivery = params[:delivery]
    erb :checkselected, locals: {size: size, crust: crust, meats: meats, veg: veg, extras: extras, delivery: delivery}
end

post '/checkselected' do
    size = params[:size]
    crust = params[:crust]
    meats = params[:meat].join(",")
    veg = params[:veggies].join(",")
    extras = params[:extras].join(",")
    delivery = params[:delivery]
    redirect 'final?size=' + size + '&crust=' + crust + '&meat=' + meats + '&veggies=' + veg + '&extras=' + extras + '&delivery=' + delivery
end

get '/final' do
    size = params[:size]
    crust = params[:crust]
    meats = eval(params[:meat])
    veg = eval(params[:veggies])
    extras = eval(params[:extras])
    delivery = params[:delivery]
    erb :final, locals: {size: size, crust: crust, meats: meats, veg: veg, extras: extras, delivery: delivery}
end

