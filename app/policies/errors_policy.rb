class ErrorsPolicy < ApplicationPolicy
  def not_found?
    # Assuming record is the resource you are checking permissions on
    user.present? && (user.admin? || (user.manager? && !record.admin?))
  end

  def internal_server_error?
    # Similar logic as not_found if needed
    user.present? && (user.admin? || (user.manager? && !record.admin?))
  end
end
