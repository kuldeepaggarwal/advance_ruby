module MyModule
	def chained_aliasing (*args)
		args.each do |fname|
			access_specifier = (public_method_defined? fname) ? "public" : ((protected_method_defined? fname) ? "protected" : "private")
			at = fname.to_s.match(/[!?]$/) ? -2 : -1
			f_with = "#{fname}".insert(at,"_with_logger") 
			f_without = "#{fname}".insert(at,"_without_logger")
			alias_method f_without.to_sym , fname
		  define_method(f_with) do
		  	puts '--logging start'
		  	instance_eval {  send (f_without) }
        puts "--logging end"
		  end
		  send access_specifier , f_without.to_sym
		  send access_specifier , f_with.to_sym		
		  alias_method fname , f_with.to_sym
		end
	end
end
class Hello
  extend MyModule
  def greet
    puts 'greet'
  end
  protected
  def protect!
    puts 'protect'
  end
  private
  def logger?
    puts 'logger'
  end
  chained_aliasing :greet, :logger?, :protect!
end
say = Hello.new
puts "Normal".center(20,'-')
say.greet
puts
puts "With_Logger".center(20,'-')
say.greet_with_logger
puts
puts "Without_Logger".center(20,'-')
say.greet_without_logger
puts
puts "Private Methods".center(25,'*')
puts Hello.private_instance_methods - Object.private_instance_methods
puts
puts "Protected Methods".center(25,'*')
puts Hello.protected_instance_methods - Object.protected_instance_methods
puts
puts "Public Methods".center(25,'*')
puts Hello.public_instance_methods - Object.public_instance_methods