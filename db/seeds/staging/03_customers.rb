30.times do
  User.create!([
    {
      first_name: Faker::Name.first_name,
      family_name: Faker::Name.last_name,
      kana_first: Faker::Name.first_name.kana,
      kana_family: Faker::Name.last_name.kana,
      email: Faker::Internet.unique.email,
      password: Faker::Internet.password(min_length: 10),
      address: Faker::Address.full_address,
      phone: Faker::PhoneNumber.phone_number
    },
    {
      first_name: Faker::Name.first_name,
      family_name: Faker::Name.last_name,
      kana_first: Faker::Name.first_name.kana,
      kana_family: Faker::Name.last_name.kana,
      email: Faker::Internet.unique.email,
      password: Faker::Internet.password(min_length: 10),
      address: Faker::Address.full_address,
      phone: Faker::PhoneNumber.phone_number
    }
  ])
end
