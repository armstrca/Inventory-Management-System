#/workspaces/Inventory-Management-System/app/policies/inventory_transaction_policy.rb
#/workspaces/Inventory-Management-System/app/policies/inventory_transactions_policy.rb
#/workspaces/Inventory-Management-System/app/policies/category_policy.rb
class InventoryTransactionPolicy < ApplicationPolicy
  def create?
    user.admin? || user.manager? || user.staff?
  end

  def show?
    user.admin? || user.manager? || user.staff?
  end

  def update?
    user.admin? || user.manager? || user.staff?
  end

  def edit?
    user.admin? || user.manager? || user.staff?
  end

  def new?
    user.admin? || user.manager? || user.staff?
  end

  def destroy?
    !(user.admin? || user.manager?) # Admins and managers can delete inventory_transactions
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
