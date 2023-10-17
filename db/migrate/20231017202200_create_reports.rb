class CreateReports < ActiveRecord::Migration[7.0]
  def change
    create_table :reports do |t|
      t.string :report_type
      t.datetime :date
      t.string :data_criteria

      t.timestamps
    end
  end
end
