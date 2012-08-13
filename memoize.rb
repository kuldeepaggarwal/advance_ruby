class A
	def initialize
	 @m = {}
	end
end

A.class_eval {
	def a(*val)
	  @m[val] ||= d(*val)
	  @m[val]
	end
	private
	def d(*val)
		puts "expense"
		val.inject {|m,n| m + n}
	end
}
t = A.new()
puts t.a(2,3,5)
puts t.a(3,5,6)
puts t.a(3,5,6)
puts t.a(5,6)
puts ('!').to_sym
b="hr"
params = 2,3,9
Class.new(A) {
def self.method_name
super(params)	
method_name
end

}