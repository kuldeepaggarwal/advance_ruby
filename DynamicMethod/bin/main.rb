require_relative "../lib/DynamicMethod.rb"
puts "exclude? 'StringToFind'"
puts "append 'AppendChar','NoOftimes'"

print 'Create class object for class "DynamicMethod(\'value\')": '
input_object = gets.chomp
object = eval input_object
print 'Enter function name and its parameters: '
input_fn = gets.chomp
object.instance_eval {
  puts eval input_fn
}