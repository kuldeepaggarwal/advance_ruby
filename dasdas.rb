module Logger
	def log(msg)
		STDERR.puts msg
	end
end

animal = "cat"
animal.extend Logger

class Subclass1
  include Logger
end
class Subclass2
	extend Logger
end
class Subclass2 
	class << self
		include Logger
	end
end
Subclass1.new().log("include technique")
Subclass2.log("Extend technique")

#l = lambda{|a| puts a}
#m = proc{|a| puts a} //Depricated
#n = proc.new {|a| puts a}

#convert (&block) 
#block
#end
#o = convert{|a| puts a}
# l|m|n|o.call()

def method_name
	puts "top"
  #[1,2,3,4].each { |val|
  #	puts val							 IS EQUIVALENT TO PROC.NEW
  #	return if val > 2
  #}
  ex = Proc.new {return}
  ex.call
  puts "bottom"
end

puts "Start"
method_name
puts "end"

def asding(start,inc)
	start -= inc
	lambda { start += inc }
end

counter = asding(10,3)
puts counter.call
puts counter.call
puts counter.call



class H
	@city=''
def m1
	"#{@city}" = "hds"
end
def m2
	puts @city
end
end

hs= H.new
hs.m1
hs.m2