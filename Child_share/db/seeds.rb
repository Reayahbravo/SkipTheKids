# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

PASSWORD = "supersecret"


Offer.destroy_all
Request.destroy_all
Booking.destroy_all
User.destroy_all

super_user = User.create(
  first_name: "Jon",
  last_name: "Snow",
  email: "js@winterfell.gov",
  password: PASSWORD,
  admin: true
)

  10.times do
    full_name = Faker::SiliconValley.character.split(' ')
    first_name = Faker::Name.first_name
    last_name = Faker::Name.last_name

    User.create(
      first_name: first_name,
      last_name: last_name,
      email: "#{first_name.downcase}.#{last_name.downcase}@example.com",
      password: PASSWORD
    )
end

users = User.all

puts Cowsay.say "Created #{users.count} users", :tux



100.times do
  c = Child.create(
    first_name: first_name,
    last_name: last_name,
    birthdate: birthdate,
    user: users.sample,
  )

  if c.valid?
    rand(0..10).times do
    Answer.create(
        body: Faker::Matz.quote,
        child: c,
        user: users.sample
    )
    end
  end
end

bookings = Booking.all
offers = Offer.all
request = Request.all

puts Cowsay.say("Created #{advertisments.count} advertisements", :frogs)
puts Cowsay.say("Created #{reviews.count} reviews", :sheep)
puts Cowsay.say("Created #{children.count} children", :ghostbusters)
puts "Login with #{super_user.email} and password of #{PASSWORD}"
