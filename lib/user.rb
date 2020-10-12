class User
  attr_accessor :email, :age

  @@infos = []
  

  def initialize(mail, age)
    @email = mail 
    @age = age
    @@infos << {@email => @age}
  end

  def self.all
    #puts @@infos
  end
end

user1 = User.new("alex@gmail.com",30)
user2 = User.new("ad@gmail.com",20)
User.all