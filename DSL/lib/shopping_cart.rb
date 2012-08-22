class ShoppingCart
  def initialize
    @items = {}
    @name = ""
    @quantity = 0
  end
  def name(nam)
    @name = nam
  end
  def quantity(qty)
    @quantity = qty
  end
  def to_s
    items = []
    @items.each do |key,value|
      items <<  key + " has " + value.to_s + " quantities\n"
    end
    items.join('')
  end
  def item
    yield self
    if @items.include? @name
       @items[@name] += @quantity
    else
      @items[@name] = @quantity
    end
  end 
end
if __FILE__ == $0
sc = ShoppingCart.new
sc.item { |i| i.name("Toothpaste"); i.quantity(3) }
sc.item { |i| i.name("Computer"); i.quantity(1) }
sc.item { |i| i.name("Computer"); i.quantity(5) }
puts sc
end