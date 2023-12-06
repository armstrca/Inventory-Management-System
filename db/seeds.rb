# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# unless Rails.env.production?
Rails.env = "production"
User.create(
  first_name: "Alice",
  last_name: "Smith",
  email: "alice@smith.com",
  password: "password",
  role: "admin",
  bio: "eyyyyy I'm walkin' heah!",
  company_id: 1,
  branch_id: 1,
)

User.create(
  first_name: "Staffy",
  last_name: "Staffy",
  email: "staff@staff.staff",
  password: "password",
  role: "staff",
  bio: "eyyyyy I'm walkin' heah!",
  company_id: 1,
  branch_id: 1,
)

User.create(
  first_name: "Mangey",
  last_name: "Manager",
  email: "manager@mangey.manga",
  password: "password",
  role: "manager",
  bio: "eyyyyy I'm walkin' heah!",
  company_id: 1,
  branch_id: 1,
)

User.create(
  first_name: "Anna",
  last_name: "Knittington",
  email: "anna@cute.girl",
  password: "forever",
  role: "admin",
  bio: "eyyyyy I'm walkin' heah!",
  company_id: 1,
  branch_id: 1,
)
