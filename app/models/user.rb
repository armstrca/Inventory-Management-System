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
#  branch_id              :integer
#  company_id             :integer
#
# Indexes
#
#  index_users_on_branch_id             (branch_id)
#  index_users_on_company_id            (company_id)
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
# Foreign Keys
#
#  branch_id   (branch_id => branches.id)
#  company_id  (company_id => companies.id)
#
class User < ApplicationRecord
  # Devise modules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Associations
  belongs_to :company
  has_many :branches
  has_one_attached :image

  # Callbacks
  before_validation :email_uniqueness_on_update

  # Validations
  validates :first_name, presence: { message: "First name is required" }
  validates :last_name, presence: { message: "Last name is required" }
  validates :email, presence: { message: "Email is required" },
                    format: { with: URI::MailTo::EMAIL_REGEXP, message: "Invalid email format" }
  validates :role, presence: { message: "Role is required" }

  # Custom validation method
  def email_uniqueness_on_update
    if email_changed? && User.where(email: email).where.not(id: id).exists?
      errors.add(:email, "has already been taken")
    end
  end

  # Devise method to update without password
  def update_without_password(params, *options)
    params.delete(:password)
    params.delete(:password_confirmation)
    update(params, *options)
  end

  # Role-related methods
  ROLES = %w[admin manager staff].freeze

  def self.admins
    where(role: "admin")
  end

  def self.managers
    where(role: "manager")
  end

  def self.staff
    where(role: "staff")
  end

  def admin?
    role == "admin"
  end

  def manager?
    role == "manager"
  end

  def staff?
    role == "staff"
  end

  # Image-related methods
  def image_url
    image.attached? ? Rails.application.routes.url_helpers.rails_blob_path(image, only_path: true) : ActionController::Base.helpers.asset_path("default_user_image.jpg")
  end

  def delete_image=(value)
    image.purge if value == "1" && image.attached?
  end

  # Class method to create a new user
  def self.create_new_user(params)
    create!(params)
  end

  # Include Ransackable module (assuming it's defined elsewhere)
  include Ransackable
end
