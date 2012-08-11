require "../lib/shopping_cart.rb"
sc = ShoppingCart.new
loop do
  print "Enter Item name('q' to quit): "
  condition = gets
  case condition
    when "q\n"
      sc.shopping_list
      puts "Bye"
      exit(ret = 0);
    else
      print "Enter the Quantity: "
      qty = gets.chomp.strip
      sc.add_item(condition.strip,qty)
  end
end