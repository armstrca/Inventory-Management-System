class ProductPolicy < ApplicationPolicy
  def create?
    user.admin? || (user.manager? && !record.admin?)
  end

  def show?
    user.admin? || (user.manager? && !record.admin? && !record.manager?)
  end
  
  def update?
    user.admin? || (user.manager? && !record.admin?)
  end

  def destroy?
    !(user.manager? && !record.admin?) # Managers cannot delete products
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
