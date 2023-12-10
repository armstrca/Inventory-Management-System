# == Schema Information
#
# Table name: roles
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  admin_id   :integer          not null
#  manager_id :integer          not null
#  staff_id   :integer          not null
#
# Indexes
#
#  index_roles_on_admin_id    (admin_id)
#  index_roles_on_manager_id  (manager_id)
#  index_roles_on_staff_id    (staff_id)
#
# Foreign Keys
#
#  admin_id    (admin_id => admins.id)
#  manager_id  (manager_id => managers.id)
#  staff_id    (staff_id => staffs.id)
#
class Role < ApplicationRecord
  belongs_to :user
  include Ransackable
end
