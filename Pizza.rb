p "Lets make some pizzas, how many would you like to make!?"

pizza = gets.chomp.to_i

def price()
    10
end

def pizza_sizes()
    size = ["small","medium","large"].sample
end

def pizza_crust()
     crust = ["thick","thin","cheesey"].sample
end

def pizza_meat()
    toppings = ["ham", "pepperoni", "sausage"].sample
end

def pizza_veggies()
    veggies = ["pineapple","peppers","mushrooms"].sample
end

def pizza_extras()
    extra_toppings = ["ham", "pepperoni", "sausage", "pineapple", "peppers", "mushrooms"].sample
end

def total(num1, num2, num3)
  p  (num1 * num2 + num3)
end

counter = 1
size_prices = 0

puts "Would you like any extra toppings, yes or no"
    wants_extras = gets.chomp

pizza.times do

    if wants_extras == "yes"
        extras = pizza_extras
    elsif wants_extras == "no"
        extras = "None"
    else 
        p "Please put yes or no."
    end

    sizes = pizza_sizes

    if sizes == "small"
        size_prices += 5
    elsif sizes == "medium"
        size_prices += 10
    elsif sizes == "large"
        size_prices += 20
    end
    
    
puts "#{counter}: \nYour pizza size is #{sizes}.\nYour pizza crust is #{pizza_crust}.\nYour pizza meats are #{pizza_meat}.\nYour pizzas veggies are #{pizza_veggies}.\nYour extras are #{extras}."

counter = counter += 1

end
p "your total is $#{total(pizza, price, size_prices)}"