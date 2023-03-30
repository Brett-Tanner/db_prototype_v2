PriceList.create!([
  {
    name: 'Spring Test',
    courses: {
      1 => 4_216,
      5 => 18_700,
      10 => 33_000,
      15 => 49_500,
      20 => 66_000,
      25 => 82_500,
      30 => 99_000
    }
  },
  {
    name: 'Spring Test',
    courses: {
      1 => 6_600,
      5 => 30_000,
      10 => 55_000,
      15 => 80_000,
      20 => 100_000,
      25 => 120_000,
      30 => 140_000
    }
  }
])

puts 'Created a member and non-member price list for testing'