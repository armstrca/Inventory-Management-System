# frozen_string_literal: true

# /workspaces/Inventory-Management-System/app/policies/storage_location_policy.rb
class StorageLocationPolicy < ApplicationPolicy
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


end
