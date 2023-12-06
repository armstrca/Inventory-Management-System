class UserPolicy < ApplicationPolicy
  def show?
    user.admin? || user.manager? || user.staff?
  end

  def create?
    user.present? && (user.admin? || (user.manager? && !record.admin?))
  end

  def new?
    user.present? && (user.admin? || (user.manager? && !record.admin?))
  end


  def admin_new?
    user.admin? || (user.manager? && !record.admin?)
  end

  def forgot_password?
    true
  end

  def edit?
    user.admin? || (user.manager? && !record.admin?) || (user.manager? && record == user) || (user.staff? && record == user)
  end

  def update?
    user.admin? || (user.manager? && !record.admin?) || (user.manager? && record == user) || (user.staff? && record == user)
  end

  def destroy?
    user.admin? || (user.manager? && !record.admin? && !record.manager?)
  end

  def edit_role?
    user.admin? || (user.manager? && !record.admin? && !record.manager?)
  end

  def permitted_attributes_for_create
    if user.admin?
      [:email, :password, :first_name, :last_name, :role, :bio, :image]
    elsif user.manager?
      [:email, :password, :first_name, :last_name, :role, :bio, :image] - [:role]
    else
      []
    end
  end

  def permitted_attributes_for_new
    if user.admin?
      [:email, :password, :first_name, :last_name, :role, :bio, :image]
    elsif user.manager?
      [:email, :password, :first_name, :last_name, :role, :bio, :image] - [:role]
    else
      []
    end
  end

  def permitted_attributes_for_update
    if user.admin?
      [:email, :password, :first_name, :last_name, :role, :bio, :image]
    elsif user.manager?
      [:email, :password, :first_name, :last_name, :bio, :image] - [:role]
    else
      []
    end
  end

  def permitted_attributes_for_edit
    if user.admin?
      [:email, :password, :first_name, :last_name, :role, :bio, :image]
    elsif user.manager?
      [:email, :password, :first_name, :last_name, :bio, :image] - [:role]
    else
      [:email, :password, :first_name, :last_name, :bio, :image] - [:role]
    end
  end
end
