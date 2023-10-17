# == Schema Information
#
# Table name: orders
#
#  id                :integer          not null, primary key
#  description       :string
#  expected_delivery :datetime
#  status            :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
class Order < ApplicationRecord
end
