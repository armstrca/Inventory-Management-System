#/workspaces/Inventory-Management-System/db/seeds.rb
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# unless Rails.env.production?
company = Company.create!(id: 1, name: "ZomboCom")
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
