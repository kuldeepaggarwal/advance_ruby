module AddMethods
  @@argss2 = {}  
  def before_filter (*args1)
    
  end
  def after_filter (*args2)
    @@argss2 = args2
    args2.each do |fname|
      puts self.instance_methods - Object.instance_methods
      # class_eval { send (fname) }
    end
  end
end
class Methods
  extend AddMethods
  
  def method_name1
   puts "in method name 1"
  end
  def method_name2
   puts "in method name 2"
  end
  def foo
   puts "in foo"
  end
  def bar
   puts "in bar"
  end
  def test_method
    puts "in test method"
  end
  before_filter :foo, :bar
  after_filter :test_method
end

m = Methods.new
# puts m.method_name.methods
# m.bar
# m.test_method
# puts Methods.new.methods
Methods.new.method_name1
# puts Methods.methods
#puts Methods.included_modules