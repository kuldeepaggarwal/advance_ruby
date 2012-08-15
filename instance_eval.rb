class Dog
end
Dog.instance_eval do
  def animal?
    puts true
  end
end
Dog.animal?

class Animal
	def initialize(name)
		@name = name
	end
end
Animal.class_eval do
  def height(val)
    @height = val
    puts "#{@name}'s height: #{@height} feet"
  end
end
cat = Animal.new("cat")
cat.height(4)

String.instance_eval do
  def kd
    puts "hi KD!"
  end
  end
s = String.new("cat")
String.class_eval do
  def tink
    puts self + " tink" 
  end
end
s.tink
"Hello".tink
s.instance_eval { puts self }