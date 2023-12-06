# /workspaces/Inventory-Management-System/lib/tasks/dev.rake

# unless Rails.env.production?
namespace :dev do
  # desc "Drops, creates, migrates, and adds sample data to database"
  # task reset: [
  #        :environment,
  #        "db:schema:cache:clear",
  #        "db:drop",
  #        "db:create",
  #        "db:migrate",
  #        "dev:sample_data",
  #      ]

  desc "Fill the database tables with some sample data"
  task sample_data: :environment do
    # Rails.env = "production"
    # ActiveRecord::Base.transaction do
    OrderProduct.where(true).delete
    Product.where(true).delete
    Order.where(true).delete
    Supplier.where(true).delete
    StorageLocation.where(true).delete
    Subcategory.where(true).delete
    Category.where(true).delete
    User.where(true).delete
    Branch.where(true).delete
    Company.where(true).delete



    company = Company.create!(name: "ZomboCom")

    branches = 3.times.map { |i| { name: "Branch #{i + 1}", company_id: company.id, created_at: Time.current, updated_at: Time.current } }
    Branch.insert_all!(branches)

    branch_ids = Branch.pluck(:id)
    roles = %w(admin staff manager)
    statuses = %w(delivered processing in_transit)
    transaction_types = %w(sale_to_customer purchase_from_supplier refund_to_customer return_to_supplier stock_loss)

    users_data = 300.times.map do
      user = User.new(password: "password")
      {
        email: Faker::Internet.unique.email,
        encrypted_password: user.encrypted_password,
        role: roles.sample,
        bio: Faker::Lorem.paragraph,
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        company_id: company.id,
        branch_id: branch_ids.sample,
        created_at: Time.current,
        updated_at: Time.current,
      }
    end

    User.insert_all!(users_data)

    categories_data = 10.times.map do
      {
        name: Faker::Commerce.department,
        description: Faker::Lorem.sentence,
        subcategory: Faker::Commerce.department,
        company_id: company.id,
        created_at: Time.current,
        updated_at: Time.current,
      }
    end
    Category.insert_all!(categories_data)

    category_ids = Category.pluck(:id)
    subcategories_data = 20.times.map do
      {
        name: Faker::Commerce.department,
        description: Faker::Lorem.sentence,
        category_id: category_ids.sample,
        company_id: company.id,
        created_at: Time.current,
        updated_at: Time.current,
      }
    end
    Subcategory.insert_all!(subcategories_data)

    storage_locations_data = 10.times.map do
      {
        name: Faker::Address.community,
        description: Faker::Lorem.sentence,
        address: Faker::Address.full_address,
        company_id: company.id,
        branch_id: branch_ids.sample,
        created_at: Time.current,
        updated_at: Time.current,
      }
    end
    StorageLocation.insert_all!(storage_locations_data)

    suppliers_data = 25.times.map do
      {
        name: Faker::Company.name,
        address: Faker::Address.full_address,
        contact_info: Faker::Internet.email,
        description: Faker::Company.catch_phrase,
        company_id: company.id,
        created_at: Time.current,
        updated_at: Time.current,
      }
    end
    Supplier.insert_all!(suppliers_data)

    storage_location_ids = StorageLocation.pluck(:id)
    addresses = StorageLocation.pluck(:address).sample(10) + 5.times.map { Faker::Address.full_address }

    orders_data = 600.times.map do
      sending_address = addresses.sample
      receiving_address = addresses.sample

      {
        expected_delivery: Faker::Date.forward(days: 30),
        status: statuses.sample,
        description: "#{["FedEx", "UPS", "USPS"].sample} tracking ##{rand(1000000000000)}",
        sending_address: sending_address,
        receiving_address: receiving_address,
        company_id: company.id,
        branch_id: branch_ids.sample,
        total: 0,
        created_at: Time.current,
        updated_at: Time.current,
      }
    end
    Order.insert_all!(orders_data)

    order_ids = Order.pluck(:id)
    products_data = 300.times.map do
      {
        name: Faker::Commerce.product_name,
        description: Faker::Lorem.sentence,
        sku: Faker::Number.number(digits: 6),
        price: Faker::Commerce.price(range: 10.0..100.0),
        stock_quantity: Faker::Number.between(from: 0, to: 1000),
        category_id: category_ids.sample,
        subcategory_id: Subcategory.pluck(:id).sample,
        supplier_id: Supplier.pluck(:id).sample, # This requires existing Supplier records
        company_id: company.id,
        branch_id: branch_ids.sample,
        created_at: Time.current,
        updated_at: Time.current,
      }
    end
    Product.insert_all!(products_data)

    product_ids = Product.pluck(:id)
    order_products_data = 2000.times.map do
      {
        quantity_ordered: Faker::Number.between(from: 2, to: 20),
        shipping_cost: Faker::Number.between(from: 1, to: 30),
        order_id: order_ids.sample,
        product_id: product_ids.sample,
        transaction_type: transaction_types.sample,
        created_at: Time.current,
        updated_at: Time.current,
      }
    end
    OrderProduct.insert_all!(order_products_data)

    # Update orders and product stock quantities
    Order.all.each do |order|
      order.calculate_total
      order.update_product_stock_quantities
      order.save!
    end

    puts "Sample data has been seeded into the database."
  end
end
# end
