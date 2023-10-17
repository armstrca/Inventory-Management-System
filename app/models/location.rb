# == Schema Information
#
# Table name: locations
#
#  id          :integer          not null, primary key
#  address     :string
#  description :string
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Location < ApplicationRecord
end
