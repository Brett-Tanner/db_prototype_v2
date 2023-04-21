User.customers.each do |customer_user|
  school = School.find(rand(1..3))
  customer_user.children.create!([
    {
      first_name: Faker::Name.first_name,
      family_name: Faker::Name.last_name,
      kana_first: Faker::Name.first_name.kana,
      kana_family: Faker::Name.last_name.kana,
      en_name: %w[Timmy Sally Billy Sarah Viktoria Brett].sample,
      birthday: Faker::Date.birthday(min_age: 2, max_age: 13),
      ssid: Faker::Number.unique.number,
      ele_school_name: Faker::GreekPhilosophers.name,
      photos: 'OK',
      allergies: 'peanuts',
      grade: '年中',
      category: :external,
      school: school
    },
    {
      first_name: Faker::Name.first_name,
      family_name: Faker::Name.last_name,
      kana_first: Faker::Name.first_name.kana,
      kana_family: Faker::Name.last_name.kana,
      en_name: %w[Timmy Sally Billy Sarah Viktoria Brett].sample,
      birthday: Faker::Date.birthday(min_age: 2, max_age: 13),
      ssid: Faker::Number.unique.number,
      ele_school_name: Faker::GreekPhilosophers.name,
      allergies: 'peanuts',
      grade: '小４',
      category: :reservation,
      school: school
    }
  ])
end

Child.create!(
  first_name: Faker::Name.first_name,
  family_name: Faker::Name.last_name,
  kana_first: Faker::Name.first_name.kana,
  kana_family: Faker::Name.last_name.kana,
  en_name: %w[Timmy Sally Billy Sarah Viktoria Brett].sample,
  birthday: 'Wed, 20 Feb 2020',
  ssid: 1,
  ele_school_name: Faker::GreekPhilosophers.name,
  photos: 'OK',
  allergies: 'peanuts',
  school: School.find(rand(1..3))
)

Child.all.each do |child|
  child.create_regular_schedule(
    monday: [true, false].sample,
    tuesday: [true, false].sample,
    wednesday: [true, false].sample,
    thursday: [true, false].sample,
    friday: [true, false].sample
  )
end
