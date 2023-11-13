module User::Roleable
  extend ActiveSupport::Concern

  ROLES = %w[admin manager staff].freeze

  included do
    scope :admin, -> { where(role: "admin") }
    scope :manager, -> { where(role: "manager") }
    scope :staff, -> { where(role: "staff") }
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
end
