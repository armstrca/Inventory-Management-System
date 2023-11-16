#/workspaces/Inventory-Management-System/app/models/report.rb
#/workspaces/Inventory-Management-System/app/models/report.rb
# == Schema Information
#
# Table name: reports
#
#  id            :integer          not null, primary key
#  data_criteria :string
#  date          :datetime
#  report_type   :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class Report < ApplicationRecord
  include Ransackable
end
