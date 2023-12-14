# frozen_string_literal: true

# /workspaces/Inventory-Management-System/app/policies/order_policy.rb
class OrderPolicy < ApplicationPolicy
  def create?
    user.staff? || user.admin? || user.manager?
  end

  def edit?
    user.staff? || user.admin? || user.manager?
  end

  def index?
    user.staff? || user.admin? || user.manager?
  end

  def index2?
    user.staff? || user.admin? || user.manager?
  end

  def incoming?
    true
  end

  def outgoing?
    true
  end

  def remove_product?
    user.admin? || user.manager?
  end

  def show?
    user.staff? || user.admin? || user.manager?
  end

  def update?
    user.staff? || user.admin? || user.manager?
  end

  def destroy?
    user.admin? || user.manager?
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
