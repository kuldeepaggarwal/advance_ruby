def calculate(operand1, operator, operand2)
  raise TypeError,"Invalid Operator" if operator.class != Symbol
  puts [operand1,operand2].reduce(operator) 
end