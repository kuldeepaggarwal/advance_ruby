animal1 = "cat"
animal2 = "dog"
  class << animal1
    def speak 
    puts "meow"
  end
end
def animal1.feet 
  puts "#{self} is of 5 feet"
end
animal1.speak
animal1.feet
animal2.speak
animal1.feet