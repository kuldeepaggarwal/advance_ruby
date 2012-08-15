require "../lib/my_object_store"
puts "First name must be capitalised,\nAge cannot be negative,\nProper email addresss be provided and phone cannot be blank \n\n"
object1 = Objects.new
object1.fname = "Kd"
object1.lname = "Aggarwal"
object1.email = "kd.engineer@yahoo.co.in"
object1.phone = "9015182145"
object1.age = 22
object1.save
object2 = Objects.new
object2.fname = "akshay"
object2.lname = "Vishnoi"
object2.email = "akshay.vishnoi@vinsol.com"
object2.age = 22
object1.phone = "9968165609"
object2.save
Objects.collect
Objects.total
puts "Searching by first name".center(35,'-')
Objects.find_by_fname("Kd")
puts "Searching by age".center(35,'-')
Objects.find_by_age("22")
puts "Searching by email".center(35,'-')
Objects.find_by_email('akshay.vishnoi@vinsol.com')
puts "Searching by lname".center(35,'-')
Objects.find_by_lname('Aggarwal')