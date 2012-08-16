module AddMethods
  def self.included(cls)
    cls.instance_eval {
      @@afters, @@befores = {}, {}  
      def before_filter (*before)
        for_before = filters(before)
        method_to_be_changed =  for_before[0]
        method_to_be_added = for_before[1]
        method_to_be_changed.each do |fname|
          @@befores[fname] = method_to_be_added - [fname]
        end
        if ( @@afters.length != 0 )
          remove_infinte_problem
          create
        end
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
          create
        end
      end
      def create
        all = self.public_instance_methods - Object.methods
          all.each do |variable|
            current_method = instance_method(variable)
            define_method "#{variable}" do
              if(@@befores[variable].class != NilClass)
                @@befores[variable].each do | b |
                  send(b)
                end
              end
              current_method.bind(self).()          
              if(@@afters[variable].class != NilClass)
                @@afters[variable].each do | a |
                  send(a)
                end
              end        
            end
          end
      end
      def remove_infinte_problem
        @@afters.each do |key,value|
          value.each do |key_for_before|
            if(@@befores[key_for_before].class != NilClass)
            indx = @@befores[key_for_before].index(key)
            if ( indx.class == Fixnum  )
              @@befores[key_for_before].delete(key)        
            end
          end
          if(@@afters[key_for_before].class != NilClass)
            indx_self =  @@afters[key_for_before].index(key)
            if ( indx_self.class == Fixnum  )
              @@afters[key_for_before].delete(key)        
            end
          end
        end
        end
        @@befores.each do |key,value|
          value.each do |key_for_before|
            if(@@befores[key_for_before].class != NilClass)
              indx_self =  @@befores[key_for_before].index(key)
              if ( indx_self.class == Fixnum  )
                @@befores[key_for_before].delete(key)        
              end
            end
          end
        end
      end
      def filters(*args)
        if args[0].last.class != Hash
          [ self.instance_methods - Object.instance_methods - args[0] ,args[0] ]
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
  include AddMethods
  after_filter :foo,:method_name1, :except => [:test_method]
  before_filter :bar,:method_name2
 
end
m = Methods.new
m.test_method