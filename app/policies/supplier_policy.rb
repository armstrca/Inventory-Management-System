#/workspaces/Inventory-Management-System/app/policies/supplier_policy.rb
#/workspaces/Inventory-Management-System/app/policies/supplier_policy.rb
class SupplierPolicy < ApplicationPolicy
  def create?
    user.admin?
  end

  def index?
    user.admin? || user.staff? || user.manager?
  end

  def show?
    user.admin? || user.staff? || user.manager?
  end

  def update?
    user.admin? || user.manager?
  end

  def destroy?
    user.admin?
  end

  def permitted_attributes_for_create
    if user.admin? || user.manager?
      # Define permitted attributes for create action
    else
      []
    end
  end

  def permitted_attributes_for_update
    if user.admin? || user.manager?
      # Define permitted attributes for update action
    else
      []
    end
  end
end
