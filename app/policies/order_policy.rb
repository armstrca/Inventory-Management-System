#/workspaces/Inventory-Management-System/app/policies/order_policy.rb
class OrderPolicy < ApplicationPolicy
  def create?
    user.staff? || user.admin? || user.manager?
  end


  def edit?
    user.staff? || user.admin? || user.manager?
  end

  def show?
    user.staff? || user.admin? || user.manager?
  end

  def update?
    user.staff? || user.admin? || user.manager?
  end

  def destroy?
    !(user.staff? && !record.admin?) # Staff cannot delete orders
  end

  def permitted_attributes_for_create
    if user.staff?
      # Define permitted attributes for create action
    else
      []
    end
  end

  def permitted_attributes_for_update
    if user.staff?
      # Define permitted attributes for update action
    else
      []
    end
  end
end
