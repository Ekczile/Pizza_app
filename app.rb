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
    meats = eval(params[:meat].join(","))
    meatplaceholder = Array.new
    meats.each do |v|
        meatplaceholder << v if params[v.to_sym] == "Yes"
    end
    meats = meatplaceholder.join(",")

    veg = eval(params[:veggies].join(","))
    vegplaceholder = Array.new
    veg.each do |v|
        vegplaceholder << v if params[v.to_sym] == "Yes"
    end
    veg = vegplaceholder.join(",")

    extras = eval(params[:extras].join(","))
    extrasplaceholder = Array.new
    extras.each do |v|
        extrasplaceholder << v if params[v.to_sym] == "Yes"
    end
    extras = extrasplaceholder.join(",")
    delivery = params[:delivery]
    address = params[:address] if params[:address]
    address = "" if !params[:address]
    redirect 'final?size=' + size + '&crust=' + crust + '&meat=' + meats + '&veggies=' + veg + '&extras=' + extras + '&delivery=' + delivery + '&address=' + address
end

get '/final' do
    size = params[:size]
    crust = params[:crust]
    meats = params[:meat]
    veg = params[:veggies]
    extras = params[:extras]
    delivery = params[:delivery]
    address = params[:address]
    erb :final, locals: {size: size, crust: crust, meats: meats, veg: veg, extras: extras, delivery: delivery, address: address}
end

