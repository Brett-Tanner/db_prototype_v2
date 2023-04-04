# This file is last to simulate users who have just created an account

non_member = User.create!(
  email: 'non_member@gmail.com',
  password: ENV['NON_MEMBER_PASS'],
  first_name: %w[Timmy Sally Billy Sarah Brett ヨシ マリナ カイト].sample,
  family_name: %w[Timmy Sally Billy Sarah Brett ヨシ マリナ カイト].sample,
  kana_first: %w[Timmy Sally Billy Sarah Brett ヨシ マリナ カイト].sample,
  kana_family: %w[Timmy Sally Billy Sarah Brett ヨシ マリナ カイト].sample,
  role: :customer,
  postcode: '216-0011',
  address: 'pizza',
  prefecture: '東京都',
  phone: '07042159870',
  school: School.all.last
)

non_member.children.create!([
  {
    first_name: %w[Timmy Sally Billy Sarah Brett ヨシ マリナ カイト].sample,
    family_name: %w[Timmy Sally Billy Sarah Brett ヨシ マリナ カイト].sample,
    kana_first: %w[Timmy Sally Billy Sarah Brett ヨシ マリナ カイト].sample,
    kana_family: %w[Timmy Sally Billy Sarah Brett ヨシ マリナ カイト].sample,
    en_name: %w[Timmy Sally Billy Sarah Viktoria Brett].sample,
    birthday: 'Fri, 21 Aug 2020',
    ssid: "#{non_member.id}#{non_member.school_id}1".to_i,
    ele_school_name: '菊名',
    allergies: '',
    grade: '年中',
    category: :external,
    school: non_member.school
  },
  {
    first_name: %w[Timmy Sally Billy Sarah Brett ヨシ マリナ カイト].sample,
    family_name: %w[Timmy Sally Billy Sarah Brett ヨシ マリナ カイト].sample,
    kana_first: %w[Timmy Sally Billy Sarah Brett ヨシ マリナ カイト].sample,
    kana_family: %w[Timmy Sally Billy Sarah Brett ヨシ マリナ カイト].sample,
    en_name: %w[Timmy Sally Billy Sarah Viktoria Brett].sample,
    birthday: 'Fri, 21 Aug 2020',
    ssid: "#{non_member.id}#{non_member.school_id}2".to_i,
    ele_school_name: '菊名',
    post_photos: true,
    allergies: '',
    grade: '小４',
    category: :external,
    school: non_member.school
  }
])

member = User.create!(
  email: 'member@gmail.com',
  password: ENV['MEMBER_PASS'],
  first_name: %w[Timmy Sally Billy Sarah Brett ヨシ マリナ カイト].sample,
  family_name: %w[Timmy Sally Billy Sarah Brett ヨシ マリナ カイト].sample,
  kana_first: %w[Timmy Sally Billy Sarah Brett ヨシ マリナ カイト].sample,
  kana_family: %w[Timmy Sally Billy Sarah Brett ヨシ マリナ カイト].sample,
  role: :customer,
  postcode: '216-0011',
  address: 'pizza',
  prefecture: '東京都',
  phone: '07042159870',
  school: School.all.last
)

member.children.create!([
  {
    first_name: %w[Timmy Sally Billy Sarah Brett ヨシ マリナ カイト].sample,
    family_name: %w[Timmy Sally Billy Sarah Brett ヨシ マリナ カイト].sample,
    kana_first: %w[Timmy Sally Billy Sarah Brett ヨシ マリナ カイト].sample,
    kana_family: %w[Timmy Sally Billy Sarah Brett ヨシ マリナ カイト].sample,
    en_name: %w[Timmy Sally Billy Sarah Viktoria Brett].sample,
    birthday: 'Fri, 21 Aug 2020',
    ssid: "#{member.id}#{member.school_id}1".to_i,
    ele_school_name: '菊名',
    post_photos: true,
    needs_hat: false,
    allergies: 'milk',
    grade: '年中',
    category: 'internal',
    school: member.school
  },
  {
    first_name: %w[Timmy Sally Billy Sarah Brett ヨシ マリナ カイト].sample,
    family_name: %w[Timmy Sally Billy Sarah Brett ヨシ マリナ カイト].sample,
    kana_first: %w[Timmy Sally Billy Sarah Brett ヨシ マリナ カイト].sample,
    kana_family: %w[Timmy Sally Billy Sarah Brett ヨシ マリナ カイト].sample,
    en_name: %w[Timmy Sally Billy Sarah Viktoria Brett].sample,
    birthday: 'Fri, 21 Aug 2020',
    ssid: "#{member.id}#{member.school_id}2".to_i,
    ele_school_name: '菊名',
    needs_hat: false,
    allergies: 'milk',
    grade: '小４',
    category: 'internal',
    school: member.school
  }
])

member.children.each do |child|
  child.create_regular_schedule!(
    monday: true,
    tuesday: false,
    wednesday: true,
    thursday: false,
    friday: false
  )
end