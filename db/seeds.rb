# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

10.times do 
    User.create(
        username: Faker::TvShows::StarTrek.unique.character.gsub(/\s+/, ""),
        password_digest: "password",
        email: Faker::TvShows::SiliconValley.unique.email,
        name: Faker::TvShows::StrangerThings.unique.character,
        location: Faker::Address.zip,
        profile_img: Faker::Avatar.image
    )
end

10.times do 
    Restaurant.create(
        name: Faker::Restaurant.unique.name,
        img: Faker::LoremFlickr.image(search_terms: ['restaurant']),
        address: Faker::Address.unique.full_address,
        phone_number: Faker::PhoneNumber.unique.cell_phone,
        description: Faker::Restaurant.unique.description,
        rating: rand(1..5),
        cuisine: Faker::Restaurant.type
    )
end