# Creates my test accounts

User.create!([
  {
    email: 'admin@gmail.com',
    password: 'adminadminadmin',
    first_name: Faker::Name.first_name,
    family_name: Faker::Name.last_name,
    kana_first: Faker::Name.first_name,
    kana_family: Faker::Name.last_name,
    role: :admin,
    address: Faker::Address.full_address,
    phone: Faker::PhoneNumber.phone_number
  },
  {
    email: 'am@gmail.com',
    password: 'ampasswordampassword',
    first_name: Faker::Name.first_name,
    family_name: Faker::Name.last_name,
    kana_first: Faker::Name.first_name,
    kana_family: Faker::Name.last_name,
    role: :area_manager,
    address: Faker::Address.full_address,
    phone: Faker::PhoneNumber.phone_number
  },
  {
    email: 'sm@gmail.com',
    password: 'smpasswordsmpassword',
    first_name: Faker::Name.first_name,
    family_name: Faker::Name.last_name,
    kana_first: Faker::Name.first_name,
    kana_family: Faker::Name.last_name,
    role: :school_manager,
    address: Faker::Address.full_address,
    phone: Faker::PhoneNumber.phone_number
  },
  {
    email: 'customer@gmail.com',
    password: 'customerpassword',
    first_name: Faker::Name.first_name,
    family_name: Faker::Name.last_name,
    kana_first: Faker::Name.first_name,
    kana_family: Faker::Name.last_name,
    role: :customer,
    address: Faker::Address.full_address,
    phone: Faker::PhoneNumber.phone_number
  }
])

puts 'Created my test accounts'

User.find_by(role: 'area_manager').managed_areas.create!(name: "神奈川県")

puts 'Gave AM an area to manage'