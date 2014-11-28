# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(
  email: 'artheriault@gmail.com',
  firstname: 'Andy',
  lastname: 'Theriault',
  password: 'password',
  password_confirmation: 'password',
  role: 1
)

30.times do 
  raise "Could not create user" unless User.create(
    email: Faker::Internet.email,
    firstname: Faker::Name.first_name,
    lastname: Faker::Name.last_name,
    password: 'password',
    password_confirmation: 'password' 
    )


  raise "Could not create movie" unless Movie.create(
    title: Faker::App.name,
    director: Faker::Name.name,
    runtime_in_minutes: rand(82..213),
    description: Faker::Lorem.paragraph,
    poster_image_url: Faker::Avatar.image,
    release_date: Faker::Date.forward(60)
    )

end
