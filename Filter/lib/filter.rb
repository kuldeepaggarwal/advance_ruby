module AddMethods
  def self.included(cls)
    cls.instance_eval {
      @@afters, @@befores = {}, {}  
      def before_filter (*before)
        method_to_be_changed,method_to_be_added = filters(before)
        method_to_be_changed.each do |fname|
          @@befores[fname] = method_to_be_added - [fname]
        end
        if ( @@afters.length != 0 )
          remove_infinte_problem
          override_existing_methods
        end
      end
      def after_filter (*after)
        method_to_be_changed,method_to_be_added = filters(after)
        method_to_be_changed.each do |fname|
          @@afters[fname] = method_to_be_added - [fname]
        end
        if ( @@befores.length != 0 )
          remove_infinte_problem
          override_existing_methods
        end
      end
      def filters(args)
        if args.last.class != Hash
          return (self.instance_methods - Object.instance_methods - args) , args
        elsif args.last[:only]
          return (args.last[:only].to_a) , (args - [args.last])
        else
          return (self.instance_methods - Object.instance_methods - args) , (args - [args.last])
        end
      end
      def override_existing_methods
        all_fn = self.public_instance_methods - Object.methods
          all_fn.each do |fn|
            current_method = instance_method(fn)
            define_method fn do
              if(@@befores[fn].class != NilClass)
                @@befores[fn].each do | before_fn |
                  send(before_fn)
                end
              end
              current_method.bind(self).()          
              if(@@afters[fn].class != NilClass)
                @@afters[fn].each do | after_fn |
                  send(after_fn)
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
            if (indx.class == Fixnum)
              @@befores[key_for_before].delete(key)        
            end
          end
          if(@@afters[key_for_before].class != NilClass)
            indx_self =  @@afters[key_for_before].index(key)
            if (indx_self.class == Fixnum)
              @@afters[key_for_before].delete(key)        
            end
          end
        end
        end
        @@befores.each do |key,value|
          value.each do |key_for_before|
            if(@@befores[key_for_before].class != NilClass)
              indx_self =  @@befores[key_for_before].index(key)
              if (indx_self.class == Fixnum)
                @@befores[key_for_before].delete(key)        
              end
            end
          end
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
  after_filter :foo,:method_name1,:only => [:foo]
  before_filter :bar,:method_name2
 
end
m = Methods.new
m.test_method