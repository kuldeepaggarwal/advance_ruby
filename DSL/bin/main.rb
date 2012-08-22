require "../lib/shopping_cart.rb"
sc = ShoppingCart.new

sc.item { |i| i.name("Laptop"); i.quantity(3) }
sc.item { |i| i.name("Desktop"); i.quantity(4) }
sc.item { |i| i.name("Chairs"); i.quantity(35) }
sc.item { |i| i.name("Keyboards"); i.quantity(40) }
sc.item { |i| i.name("Chairs"); i.quantity(35) }
puts sc