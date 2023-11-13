#/workspaces/Inventory-Management-System/app/controllers/custom_devise/registrations_controller.rb
# app/controllers/custom_devise/registrations_controller.rb
class CustomDevise::RegistrationsController < Devise::RegistrationsController
  prepend_before_filter :require_no_authentication, only: [:cancel ]
  # before_action :authenticate_user!

  # def new
  #   @user = User.new
  #   authorize @user

  #   @action = "Create User" # Set the action for the button
  #   if @user.new_record?
  #     @form_url = users_path
  #     @http_method = :post
  #   else
  #     @form_url = user_path(@user)
  #     @http_method = :patch
  #   end
  # end

  # def create
  #   @user = User.new(user_params)
  #   authorize @user

  #   respond_to do |format|
  #     if @user.save
  #       format.html { redirect_to user_url(@user), notice: "User was successfully created." }
  #       format.json { render :show, status: :created, location: @user }
  #     else
  #       format.html { render :new, status: :unprocessable_entity }
  #       format.json { render json: @user.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # # Other actions...

  # protected

  # def sign_up_params
  #   # Customize the permitted parameters for user creation
  #   params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :role, :bio, :image)
  # end
end
