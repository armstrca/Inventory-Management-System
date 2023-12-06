# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# unless Rails.env.production?
company = Company.create!(name: "ZomboCom")
if company.persisted?
  puts company.inspect
else
  puts company.errors.full_messages
end
branches = 3.times.map { |i| { name: "Branch #{i + 1}", company_id: company.id, created_at: Time.current, updated_at: Time.current } }
Branch.insert_all!(branches)
if branches.sample.persisted?
  puts branches.inspect
else
  puts branches.errors.full_messages
end
u1 = User.create(
  first_name: "Alice",
  last_name: "Smith",
  email: "alice@smith.com",
  password: "password",
  role: "admin",
  bio: Faker::Lorem.paragraph,
  company_id: 1,
  branch_id: 1,
)
if u1.persisted?
  puts u1.inspect
else
  puts u1.errors.full_messages
end
u2 = User.create(
  first_name: "Staffy",
  last_name: "Staffy",
  email: "staff@staff.staff",
  password: "password",
  role: "staff",
  bio: Faker::Lorem.paragraph,
  company_id: 1,
  branch_id: 1,
)
if u2.persisted?
  puts u2.inspect
else
  puts u2.errors.full_messages
end
u3 = User.create(
  first_name: "Mangey",
  last_name: "Manager",
  email: "manager@mangey.manga",
  password: "password",
  role: "manager",
  bio: Faker::Lorem.paragraph,
  company_id: 1,
  branch_id: 1,
)
if u3.persisted?
  puts u3.inspect
else
  puts u3.errors.full_messages
end
u4 = User.create(
  first_name: "Anna",
  last_name: "Knittington",
  email: "anna@cute.girl",
  password: "forever",
  role: "admin",
  bio: Faker::Lorem.paragraph,
  company_id: 1,
  branch_id: 1,
)
if u4.persisted?
  puts u4.inspect
else
  puts u4.errors.full_messages
end
