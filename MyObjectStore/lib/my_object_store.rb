module MyObjectStore
  def self.included(cls)
    cls.class_eval {
      @@find_bys = (cls.new.public_methods - Object.methods).to_a.uniq!{|s| s[/^\w+/]}
      @@save_obj = Array.new(0,Hash.new())
      define_method( :save ) do
        msg = ""
        if ( (self.class.validate_presence_of (self) )  && ( ( self.class.public_method_defined? :validate) ? validate : :false ))
          p "#{fname}'s details are valid"
          save_format = ""
          @@find_bys.each do |d|
            save_format += "\"#{d.to_s}\"=>\"" + (send(d)).to_s + "\","
          end
          save_format_hash = eval "{" + save_format +" }"
          @@save_obj << save_format_hash
        else
           puts "invalid".center(20,'*')
           p self
        end
      end
    }
    cls.instance_eval do
      def validate_presence_of(*arg)
        result = true
        if(arg.length ==1 )
          arg[0].instance_eval {
            @@find_bys.each do |variable|
              if (send(variable).to_s == "")
                return false
              end
            end
          }
        end
      end
      def collect
        puts
        puts puts "all valid data:".center(20,'-')
        @@save_obj.each do |variable|
          puts variable
        end 
        puts
        puts puts "end".center(20,'-')
      end      
      def total
        puts "total added: #{@@save_obj.length}"
      end
      class << self
        @@find_bys.each do |find_fn|
          fn = "find_by_#{find_fn}"
          define_method fn do |value|
            result = []
            @@save_obj.each do |variable|
              if variable["#{find_fn}"] == value
                result << value
              end
            end
            display = result.length > 0 ? result : "No match Found"
            puts "Result Matched: #{display} "
            puts "No. of matched enteries: #{result.length}"
          end
        end
      end
    end
  end
end
class Objects
  attr_accessor :age, :fname, :email, :lname, :phone
  include MyObjectStore
  validate_presence_of :fname, :email, :age, :lname, :phone
  def validate
    (age > -1) ? ((fname == fname.capitalize) ? ((email.match(/^[A-Za-z]([A-Za-z0-9]|[.\-_][A-Za-z0-9])*@[A-Za-z0-9]([A-Za-z0-9]|[.][A-Za-z0-9])+([.][A-Za-z]{2,4})$/).class != NilClass ) ? true : false) : false) : false 
  end
end
if __FILE__ == $0
  a = Objects.new
  a.fname = "Kd"
  a.email = "kd.engineer@yahoo.co.in"
  a.age = 22
  a.lname = "a"
  a.save
  a.fname = "Akshay"
  a.lname = "v"
  a.email = "akshay.vishnoi@vinsol.co.mmmmm"
  a.age = 22
  a.save
  Objects.collect
  Objects.total
  Objects.find_by_fname("Kd")
  Objects.find_by_age("22")
end