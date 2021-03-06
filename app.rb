require 'sinatra'

get '/' do
    anotherpizza = params[:apizza] if params[:apizza]
    anotherpizza = "" if !params[:apizza]
    erb :home, locals: {anotherpizza: anotherpizza}
end

post '/home' do
    size = params[:size]
    crust = params[:crust]
    meats = params[:meat].join(', ') if params[:meat]
    meats = "" if !params[:meat]
    veg = params[:veggies].join(', ') if params[:veggies]
    veg = "" if !params[:veggies]
    extras = params[:extras].join(', ') if params[:extras]
    extras = "" if !params[:extras]
    anotherpizza = params[:apizza]
    redirect 'checkselected?size=' + size + '&crust=' + crust + '&meat=' + meats + '&veggies=' + veg + '&extras=' + extras + '&apizza=' + anotherpizza
end

get '/checkselected' do
    size = params[:size]
    crust = params[:crust]
    meats = params[:meat].split(", ")
    veg = params[:veggies].split(", ")
    extras = params[:extras].split(", ")
    delivery = params[:delivery]
    anotherpizza = params[:apizza]
    erb :checkselected, locals: {size: size, crust: crust, meats: meats, veg: veg, extras: extras, delivery: delivery, anotherpizza: anotherpizza}
end

post '/checkselected' do
    puts "params before anything #{params}"
    size = params[:size]
    crust = params[:crust]
    meats = params[:meat].split(", ")
    meatplaceholder = Array.new
        if params["ham"] == "Yes"
            meatplaceholder << "ham "
        end
        if params["pepperoni"] == "Yes"
            meatplaceholder << "pepperoni "
        end
        if params["sausage"] == "Yes"
            meatplaceholder << "sausage "
        end
    meats = meatplaceholder
   
    veg = params[:veggies].split(", ")
    vegplaceholder = Array.new
    if params["pineapple"] == "Yes"
        vegplaceholder << "pineapple "
    end
    if params["peppers"] == "Yes"
        vegplaceholder << "peppers "
    end
    if params["mushrooms"] == "Yes"
        vegplaceholder << "mushrooms "
    end
    veg = vegplaceholder

    extras = params[:extras].split(", ")
    extrasplaceholder = Array.new
    if params["ham"] == "Yes"
        extrasplaceholder << "ham "
    end
    if params["extra pepperoni"] == "Yes"
        extrasplaceholder << "extra pepperoni "
    end
    if params["extra sausage"] == "Yes"
        extrasplaceholder << "extra sausage "
    end
    if params["extra pineapple"] == "Yes"
        extrasplaceholder << "extra pineapple "
    end
    if params["extra peppers"] == "Yes"
        extrasplaceholder << "extra peppers "
    end
    if params["extra mushrooms"] == "Yes"
        extrasplaceholder << "extra mushrooms "
    end
    extras = extrasplaceholder

    delivery = params[:delivery]
    anotherpizza = params[:apizza].split()
    if anotherpizza == ""
        anotherpizza = Array.new
    else 
        anotherpizza = params[:apizza]
    end
        anotherpizza << size
        anotherpizza << crust
        anotherpizza << meats.join() 
        anotherpizza << veg.join()
        anotherpizza << extras.join()
        anotherpizza = anotherpizza
        if delivery == "New Pizza"
        redirect '/?apizza=' + anotherpizza + '&delivery=' + delivery
        end
    redirect 'final?apizza=' + anotherpizza + '&delivery=' + delivery
end

get '/final' do
    price = 0
    anotherpizza = params[:apizza]
    if anotherpizza.include?("Small")
        price += 5.00 * anotherpizza.scan(/Small/).length
    end
    if anotherpizza.include?("Medium") 
        price += 8.00 * anotherpizza.scan(/Medium/).length
    end
    if anotherpizza.include?("Large") 
        price += 10.00 * anotherpizza.scan(/Large/).length
    end
    if anotherpizza.include?("thick")
        price += 2.00 * anotherpizza.scan(/thick/).length
    end
    if anotherpizza.include?("thin")
        price += 1.00 * anotherpizza.scan(/thin/).length
    end
    if anotherpizza.include?("cheesey")
        price += 5.00* anotherpizza.scan(/cheesey/).length
    end
    if anotherpizza.include?("ham")
        price += 1.50 * anotherpizza.scan(/ham/).length
    end
    if anotherpizza.include?("pepperoni")
        price += 1.50 * anotherpizza.scan(/pepperoni/).length
    end
    if anotherpizza.include?("sausage")
        price += 1.50 * anotherpizza.scan(/sausage/).length
    end
    if anotherpizza.include?("pineapple")
        price += 1.50 * anotherpizza.scan(/pineapple/).length
    end
    if anotherpizza.include?("peppers")
        price += 1.50 * anotherpizza.scan(/peppers/).length
    end
    if anotherpizza.include?("mushrooms")
        price += 1.50 * anotherpizza.scan(/mushrooms/).length
    end

    delivery = params[:delivery]
        if params[:delivery]
            price += 5.00
        end
        address = params[:address] if params[:address]
        address = "" if !params[:address]
    price = sprintf "%.2f", price
    erb :final, locals: {anotherpizza: anotherpizza, delivery: delivery, address: address, price: "$".concat(price)}
end

post '/final' do
    address = params[:address]
    redirect 'delivery?address=' + address
end

get '/delivery' do
    address = params[:address]
    erb :delivery, locals: {address: address}
end