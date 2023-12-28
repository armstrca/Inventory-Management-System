# frozen_string_literal: true

# /workspaces/Inventory-Management-System/app/policies/order_product_policy.rb
class OrderProductPolicy < ApplicationPolicy
  def create?
    user.staff? || user.admin? || user.manager?
  end

  def show?
    user.staff? || user.admin? || user.manager?
  end

  def update?
    user.staff? || user.admin? || user.manager?
  end

  def new?
    user.staff? || user.admin? || user.manager?
  end

  def index?
    user.staff? || user.admin? || user.manager?
  end

  def destroy?
    !user.staff? # Staff cannot delete order products
  end


end
