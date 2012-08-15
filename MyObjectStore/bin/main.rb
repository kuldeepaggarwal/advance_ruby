require "../lib/my_object_store"

object1 = Objects.new
object1.fname = "Kd"
object1.email = "kd.engineer@yahoo.co.in"
object1.age = 22
object1.save
object2 = Objects.new
object2.fname = "Akshay"
object2.email = "akshay.vishnoi@vinsol.com"
object2.age = 22
object2.save
Objects.collect
Objects.total
puts "Searching by first name".center(25,'-')
Objects.find_by_fname("Kd")
puts "Searching by age".center(25,'-')
Objects.find_by_age("22")
puts "Searching by email".center(25,'-')
Objects.find_by_email('akshay.vishnoi@vinsol.com')