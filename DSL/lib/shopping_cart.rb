class ShoppingCart
  def initialize
    @items = []
  end
  def shopping_list
    puts @items.join("\n")
  end
  def add_item ( name , quantity )
    @items << "Name : #{name}, Quantity: #{quantity}"
  end
end

