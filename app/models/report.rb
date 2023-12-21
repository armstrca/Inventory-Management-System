# frozen_string_literal: true

# /workspaces/Inventory-Management-System/app/models/report.rb
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
#  branch_id     :integer
#  company_id    :integer
#
# Indexes
#
#  index_reports_on_branch_id   (branch_id)
#  index_reports_on_company_id  (company_id)
#
# Foreign Keys
#
#  branch_id   (branch_id => branches.id)
#  company_id  (company_id => companies.id)
#
class Report < ApplicationRecord
  belongs_to :company
  belongs_to :branch, optional: true
  include Ransackable
end
