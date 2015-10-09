Fabricator(:user) do
  email { Faker::Internet.email }
  password { '12345678' }
  password_confirmation { '12345678' }
  full_name { Faker::Name.name }
end