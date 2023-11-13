class OrderProductPolicy < ApplicationPolicy
  def create?
    user.staff?
  end

  def show?
    user.admin? || (user.manager? && !record.admin? && !record.manager?)
  end
  
  def update?
    user.staff?
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
