class Print
  def initialize(name)
    self.class.create_method(name)
  end
  def self.create_method(method_name)
    define_method("#{method_name}") do |block|
      eval block
    end
  end 
end
puts "-----Enter the function name------"
f_name = gets.chomp
#f_name = "a"
m = Print.new(f_name)
puts "Enter one line code"
code = gets
#code = "puts 'hello'
puts "----------Output-----------"
m.send(f_name ,code )