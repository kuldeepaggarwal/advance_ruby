module AddMethods
  def self.included(cls)
    cls.instance_eval {
    @@s = cls
  @@afters, @@befores = {}, {}  
  def self.before_filter (*before)
    for_before = filters(before)
    method_to_be_changed =  for_before[0]
    method_to_be_added = for_before[1]
    method_to_be_changed.each do |fname|
      @@befores[fname] = method_to_be_added - [fname]
    end
    if ( @@afters.length != 0 )
      puts @@befores
      puts @@afters
       remove_infinte_problem
      # create
    end
  end
  def create
    
    all = self.public_instance_methods - Object.methods
      all.each do |variable|
        a = instance_method(variable)
        define_method "#{variable}" do
          if(@@befores[variable].class != NilClass)
            @@befores[variable].each do | b |
              send(b)
            end
          end
          # puts "normal"
          a.bind(self).()          
          if(@@afters[variable].class != NilClass)
            @@afters[variable].each do | a |
              send(a)
            end
          end
        
        end
      end
        # alias_method :method_name2 , :method_name21
  end
  def after_filter (*after)
    for_after = filters(after)
    method_to_be_changed =  for_after[0]
    method_to_be_added = for_after[1]
    method_to_be_changed.each do |fname|
      @@afters[fname] = method_to_be_added - [fname]
    end
    if ( @@befores.length != 0 )
       remove_infinte_problem
       # create
    end
  end
  def remove_infinte_problem
    puts "before".center(15,'-')
    puts "after".center(15,'-')
    @@afters.each do |key,value|
      value.each do |key_for_before|
        # puts key
        # puts "key"
        # puts key
        # puts "for before"
        # puts key_for_before
        
        indx = @@befores[key_for_before].index(key)
        if ( indx.class == Fixnum  )
          puts "#{key}'s #{key_for_before} contains #{key} at #{indx}"
          # (@@befores[key_for_before].delete_at(indx))
          # puts @@befores[key_for_before].delete(key)
          # puts @@befores[key_for_before].delete(:foo)
        
      end
      end
    end
  end
  def filters(*args)
    if args[0].last.class != Hash
      [ self.instance_methods - Object.instance_methods ,args[0] ]
    elsif args[0].last[:only]
      return [(args[0].last[:only].to_a) , (args[0] - [args[0].last])]
    else
      [self.instance_methods - Object.instance_methods - args[0] - args[0].last[:except], (args[0] - [args[0].last])]
    end
  end
}
end
end
class Methods
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
  def sample_instance_method
    puts "in sample "
  end
  include AddMethods
  after_filter :foo
  before_filter :bar
 
end
puts "".center(25,'-')
m = Methods.new
# puts m.methods - Object.methods
# puts m.method_name.methods
# m.bar
m.sample_instance_method
# m.test_method
# puts Methods.new.methods
# m.method_name11
# puts Methods.methods
#puts Methods.included_modules