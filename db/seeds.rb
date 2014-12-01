# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Tmdb::Api.key('5cc38f28d0fb23ed45663d4dd805e56c')

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

  credits = nil
  while credits.nil? do
    num = rand(320..1231)
    movie = Tmdb::Movie.detail(num)
    credits = Tmdb::Movie.credits(num)
    credits = nil if credits[:crew].nil? || credits[:crew].first.nil?
  end

  raise "Could not create movie" unless Movie.create(
    title: movie.title,
    director: credits[:crew].first.name,
    runtime_in_minutes: movie.runtime,
    description: movie.overview,
    release_date: Moviee.release_date,
    remote_poster_url: "http://image.tmdb.org/t/p/w154#{movie.poster_path}"
    )
end