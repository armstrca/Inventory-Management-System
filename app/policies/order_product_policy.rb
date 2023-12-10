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
    !(user.staff?) # Staff cannot delete order products
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
