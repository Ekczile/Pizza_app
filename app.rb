require 'sinatra'

get '/' do
    erb :home
end

post '/home' do
    size = params[:size]
    crust = params[:crust]
    meats = params[:meat].join(",") if params[:meat]
    meats = "" if !params[:meat]
    veg = params[:veggies].join(",") if params[:veggies]
    veg = "" if !params[:veggies]
    extras = params[:extras].join(",") if params[:extras]
    extras = "" if !params[:extras]
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
    price = 0
    size = params[:size]
    if size == "Small"
        price += 5.00
    elsif size == "Medium"
        price += 8.00
    elsif size == "Large"
        price += 10.00
    end
    crust = params[:crust]
    if crust == "thick"
        price += 2.00
    elsif crust == "thin"
        price += 1.00
    elsif crust == "cheesey"
        price += 5.00
    end
    meats = params[:meat]
    if meats.include?("ham")
        price += 1.50
    end
    if meats.include?("pepperoni")
        price += 1.50
    end
    if meats.include?("sausage")
        price += 1.50
    end
    veg = params[:veggies]
    if veg.include?("pineapple")
        price += 1.50
    end
    if veg.include?("peppers")
        price += 1.50
    end
    if veg.include?("mushrooms")
        price += 1.50
    end
    extras = params[:extras]
    if extras.include?("ham")
        price += 1.50
    end
    if extras.include?("pepperoni")
        price += 1.50
    end
    if extras.include?("sausage")
        price += 1.50
    end
    if extras.include?("pineapple")
            price += 1.50
    end
    if extras.include?("peppers")
            price += 1.50
    end
    if extras.include?("mushrooms")
            price += 1.50
    end
    delivery = params[:delivery]
    address = params[:address]
    price = sprintf "%.2f", price
    erb :final, locals: {size: size, crust: crust, meats: meats, veg: veg, extras: extras, delivery: delivery, address: address, price: price}
end

