#/workspaces/Inventory-Management-System/app/models/user.rb
# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  bio                    :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string
#  image                  :string
#  last_name              :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  role                   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord

validate :email_uniqueness_on_update, on: :update
include Ransackable
def email_uniqueness_on_update
  if email_changed? && User.exists?(email: email)
    errors.add(:email, 'has already been taken')
  end
end
has_one_attached :image

def image_url
  if image.attached?
    Rails.application.routes.url_helpers.rails_blob_path(image, only_path: true)
  else
    '/img/default_user_image.jpg' # Provide a default image URL or handle this case as needed
  end
end

  devise :database_authenticatable
  ROLES = %w[admin manager staff].freeze
  def self.admins
    User.where(role: "admin")
  end

  def self.managers
    User.where(role: "manager")
  end

  def self.staff
    User.where(role: "staff")
  end

  validates :first_name, presence: { message: "First name is required" }
  validates :last_name, presence: { message: "Last name is required" }
  validates :email, presence: { message: "Email is required" },
                    format: { with: URI::MailTo::EMAIL_REGEXP, message: "Invalid email format" }
  validates :role, presence: { message: "Role is required" }
end
