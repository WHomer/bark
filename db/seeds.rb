# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user_1 = User.create!(name: 'user 1', password: 'password123', email: 'user1@example.com')
user_2 = User.create!(name: 'user 2', password: 'password123', email: 'user2@example.com')
user_3 = User.create!(name: 'user 3', password: 'password123', email: 'user3@example.com')

dogs = [
  {
    name: 'Bowie',
    description: 'Bowie dances when he walks',
    user_id: user_1.id
  },
  {
    name: 'Brownie',
    description: 'Brownie only sits pretty',
    user_id: user_2.id
  },
  {
    name: 'Jax',
    description: '',
    user_id: user_3.id
  },
  {
    name: 'Jiro',
    description: 'Jiro takes a long time to destroy his toys',
    user_id: user_1.id
  },
  {
    name: 'Pete',
    description: 'Pete has a best friend named Lua',
    user_id: user_1.id
  },
  {
    name: 'Bijou',
    description: 'Bijou is the fluffiest of them all',
    user_id: user_1.id
  },
    {
    name: 'Britta',
    description: 'Britta has two different colored eyes',
    user_id: user_1.id
  },
  {
    name: 'Noodle',
    description: 'Noodle is an Instagram celebrity',
    user_id: user_1.id
  },
  {
    name: 'Stella',
    description: 'Stella loves to dig',
    user_id: user_1.id
  },
  {
    name: 'Tonks',
    description: 'Tonks loves to run',
    user_id: user_1.id
  },
]

dogs.each do |dog|
  dog = Dog.find_or_create_by(name: dog[:name], description: dog[:description], user_id: dog[:user_id])
  directory_name = File.join(Rails.root, 'db', 'seed', "#{dog[:name].downcase}", "*")

  Dir.glob(directory_name).each do |filename|
    if !dog.images.any?{|i| i.filename == filename}
      dog.images.attach(io: File.open(filename), filename: filename.split("/").pop)
      sleep 1
    end
  end
end
