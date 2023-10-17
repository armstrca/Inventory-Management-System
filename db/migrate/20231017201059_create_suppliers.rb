class CreateSuppliers < ActiveRecord::Migration[7.0]
  def change
    create_table :suppliers do |t|
      t.string :name
      t.string :contact_info
      t.string :description
      t.string :standing

      t.timestamps
    end
  end
end
