class ShoppingCart
  attr_writer :name , :quantity
  def initialize
    @items = []
  end
  def name(nam)
    @name = nam
  end
  def quantity(qty)
    @quantity = qty
  end
  def to_s
    @items.join("\n")
  end
  def item
    yield self
    @items << @name + ":" + @quantity.to_s + " quantities"
  end 
end
if __FILE__ == $0
sc = ShoppingCart.new
sc.item { |i| i.name("Toothpaste"); i.quantity(3) }
sc.item { |i| i.name("Computer"); i.quantity(1) }
puts sc
end