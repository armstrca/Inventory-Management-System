# /workspaces/Inventory-Management-System/lib/tasks/dev.rake

# unless Rails.env.production?
namespace :dev do
  desc "Drops, creates, migrates, and adds sample data to database"
  task reset: [
         :environment,
         "db:schema:cache:clear",
         "db:drop",
         "db:create",
         "db:migrate",
         "dev:sample_data",
       ]

  desc "Fill the database tables with some sample data"
  task sample_data: :environment do
    # if Rails.env.development?

    supplier_company_names = 50.times.map { Faker::Company.name }
    supplier_catchphrases = 50.times.map { Faker::Company.catch_phrase }

    company = Company.create(name: "ZomboCom")

    branches = 3.times.map do |i|
      { name: "Branch #{i + 1}", company_id: company.id }
    end
    Branch.create!(branches)

    puts "One company with three branches created."

    generated_emails = []

    users = 100.times.map do
      email = Faker::Internet.unique.email
      while generated_emails.include?(email)
        email = Faker::Internet.unique.email
      end
      generated_emails << email

      {
        email: email,
        password: "password",
        role: %w(admin staff manager).sample,
        bio: Faker::Lorem.paragraph,
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        company_id: company.id,
        branch_id: branches.sample.id,
      }
    end
    User.create!(users)

    User.create(
      first_name: "Alice",
      last_name: "Smith",
      email: "alice@smith.com",
      password: "password",
      role: "admin",
      bio: Faker::Lorem.paragraph,
      company_id: company.id,
      branch_id: branches.sample.id,
    )

    User.create(
      first_name: "Staffy",
      last_name: "Staffy",
      email: "staff@staff.staff",
      password: "password",
      role: "staff",
      bio: Faker::Lorem.paragraph,
      company_id: company.id,
      branch_id: branches.sample.id,
    )

    User.create(
      first_name: "Mangey",
      last_name: "Manager",
      email: "manager@mangey.manga",
      password: "password",
      role: "manager",
      bio: Faker::Lorem.paragraph,
      company_id: company.id,
      branch_id: branches.sample.id,
    )

    User.create(
      first_name: "Anna",
      last_name: "Knittington",
      email: "anna@cute.girl",
      password: "forever",
      role: "admin",
      bio: Faker::Lorem.paragraph,
      company_id: company.id,
      branch_id: branches.first.id,
    )
    puts "104 users created"

    categories = 20.times.map do
      {
        name: Faker::Commerce.department,
        description: Faker::Lorem.sentence,
        subcategory: Faker::Commerce.department,
        company_id: company.id,
      }
    end
    Category.create!(categories)
    puts "20 categories created"

    subcategories = 40.times.map do
      {
        name: Faker::Commerce.department,
        description: Faker::Lorem.sentence,
        category: categories.sample,
        company_id: company.id,
      }
    end
    Subcategory.create!(subcategories)
    puts "40 subcategories created"

    storage_locations = 10.times.map do
      {
        name: Faker::Address.community,
        description: Faker::Lorem.sentence,
        address: Faker::Address.full_address,
        company_id: company.id,
        branch_id: branches.sample.id,
      }
    end
    StorageLocation.create!(storage_locations)
    puts "10 storage_locations created"

    location_addresses = StorageLocation.pluck(:address).sample(10)
    faker_addresses = 5.times.map { Faker::Address.full_address }
    addresses = location_addresses + faker_addresses

    orders = 1000.times.map do
      sending_address = addresses.sample
      receiving_address = addresses.sample

      while !(StorageLocation.exists?(address: sending_address) || StorageLocation.exists?(address: receiving_address))
        sending_address = addresses.sample
        receiving_address = addresses.sample
      end

      {
        expected_delivery: Faker::Date.forward(days: 30),
        status: %w(delivered processing in_transit).sample,
        description: "#{["FedEx", "UPS", "USPS"].sample} tracking ##{rand(1000000000000)}",
        sending_address: sending_address,
        receiving_address: receiving_address,
        company_id: company.id,
        branch_id: branches.sample.id,
        total: 0,
      }
    end
    Order.create!(orders)
    puts "1000 orders created"

    10.times do
      Report.create(
        report_type: Faker::Lorem.word,
        date: Faker::Time.backward(days: 90),
        data_criteria: Faker::Lorem.sentence,
        company_id: company.id,
        branch_id: branches.sample.id,
      )
    end
    puts "10 reports created"

    suppliers = 50.times.map do
      {
        name: supplier_company_names.uniq.sample,
        address: Faker::Address.full_address,
        contact_info: Faker::Internet.email,
        description: supplier_catchphrases.uniq.sample,
        company_id: company.id,
      }
    end
    Supplier.create!(suppliers)
    puts "50 suppliers created"

    products = 600.times.map do
      {
        name: Faker::Commerce.product_name,
        description: Faker::Lorem.sentence,
        sku: Faker::Number.number(digits: 6),
        price: Faker::Commerce.price(range: 10.0..100.0),
        stock_quantity: Faker::Number.between(from: 0, to: 1000),
        category_id: categories.sample.id,
        subcategory_id: subcategories.sample.id,
        supplier_id: suppliers.sample.id,
        company_id: company.id,
        branch_id: branches.sample.id,
      }
    end
    Product.create!(products)
    puts "600 products created"

    order_products = 4500.times.map do
      {
        quantity_ordered: Faker::Number.between(from: 2, to: 20),
        shipping_cost: Faker::Number.between(from: 1, to: 30),
        order_id: orders.sample.id,
        product_id: products.sample.id,
        transaction_type: %w(sale_to_customer purchase_from_supplier refund_to_customer return_to_supplier stock_loss).sample,
      }
    end
    OrderProduct.create!(order_products)
    puts "4500 order_products created"

    Order.all.each do |o|
      o.order_products.each do |order_product|
        order_product_amount = o.calculate_transaction_amount(order_product)
        o.update_product_stock(order_product.product, order_product.quantity_ordered) if order_product_amount != 0
      end

      o.calculate_total
      o.save
    end

    puts "Order totals and stock quantities calculated"
    puts "Sample data has been seeded into the database."
  end
end
