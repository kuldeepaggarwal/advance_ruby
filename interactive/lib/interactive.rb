puts "*********Enter your code to execute.Press q/Q to exit**********"
line = ""
loop do 
  condition = gets
  case condition
    when "q\n"
      puts "Bye"
      exit(ret = 0);
    when "\n"  	 
      eval line
      line = ""
    else
      line = line + condition
  end
end
