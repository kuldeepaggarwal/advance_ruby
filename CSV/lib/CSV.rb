if __FILE__ == $0 
  @fileloc = '../bin/players.csv'
elsif ( @fileloc == "")
  @fileloc = '../bin/players.csv'
end
classname_pattern = /\/?([A-z]+).csv$/i
classname_pattern.match(@fileloc)
class_name = ($1).capitalize
lines = []
File.readlines(@fileloc).each { |line| lines << line }
function_names = lines[0].split(',')
function_names.each { |n| n.strip! }
obj = []
cls = eval "class #{class_name}
  self
end"
cls.class_eval {
  attr_accessor *function_names
  def self.rw_method(n)
    define_method(n) do |*val|
      if val.length != 0
        instance_variable_set("@" + n, val[0].to_s.strip)
      else
        puts n + " : " + instance_variable_get("@" + n)
      end
    end
  end
  (function_names.length).times do |i| 
    rw_method(function_names[i])
  end
}
1.upto(lines.length - 1) do |index|
  values = lines[index].split(',')
  obj[index - 1] = cls.new
  0.upto( values.length - 1) do |at|
    obj[index - 1].send( function_names[at] ,values[at])
  end
end
obj.each do |ob|
  function_names.each do |fname|
    ob.send(fname)
  end
  puts
end