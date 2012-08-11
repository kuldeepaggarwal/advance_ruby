class DynamicMethod < String
	def initialize value
		@value = value
	end
  def exclude? substring 
    !@value.include?substring
  end
  def append ( *args )
    1.upto(args[1].to_i) { @value = args[0] + @value + args[0] }
    @value
  end
end

if __FILE__ == $0
  dm = DynamicMethod.new("iti")
  puts dm.append('N','1')
end