#/workspaces/Inventory-Management-System/app/controllers/users_controller.rb
#/workspaces/Inventory-Management-System/app/controllers/users_controller.rb
class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]
  before_action :set_form_variables, only: %i[new edit]

  rescue_from ActiveRecord::RecordNotUnique, with: :email_not_unique

  # devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
    @user = User.find(params[:id])
    authorize @user
  end

  # def savenew
  #   User.create_new_user(user_params)
  #   redirect_to action: 'index'
  # end

  # GET /users/new
  def new
    @user = User.new

    @action = "Create User" # Set the action for the button
    if @user.new_record?
      @form_url = users_path
      @http_method = :post
    else
      @form_url = user_path(@user)
      @http_method = :patch
    end
  end

  # def check_email_availability
  #   email = params[:email]
  #   user = User.find_by(email: email)

  #   if user
  #     render json: { available: false }
  #     # format.html { render :edit, status: :unprocessable_entity }
  #     # format.json { render json: @user.errors, status: :unprocessable_entity }
  #   else
  #     render json: { available: true }
  #   end
  # end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
    authorize @user # Add authorization check
    @action = "Update User" # Set the action for the button
  end

  def update
    @user = User.find(params[:id])
    authorize @user # Add authorization check

    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_url(@user), notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def create
    @user = User.new(user_params)
    authorize @user

    respond_to do |format|
      if @user.save
        format.html { redirect_to user_url(@user), notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user = User.find(params[:id])
    authorize @user
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password,
                                 :password_confirmation)
  end


  def user_params_without_password
    # Allow updating all user attributes except password-related ones
    params.require(:user).permit(:first_name, :last_name, :email, :role, :bio, :image)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = current_user
  end

  def authorize_user
    authorize User
  end

  def set_form_variables
    @action = action_name == "new" ? "Create User" : "Update User"
    @form_url = action_name == "new" ? users_path : user_path(@user)
    @http_method = action_name == "new" ? :post : :patch
  end

  def email_not_unique
    respond_to do |format|
      format.html do
        flash.now[:error] = "Email address is already taken. Please choose a different one."
        render :new, status: :unprocessable_entity
      end
      format.json { render json: { error: "Email address is already taken. Please choose a different one." }, status: :unprocessable_entity }
    end
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :role, :bio, :image)
  end

  def valid_email?(email)
    # Use a regular expression to validate the email format
    email =~ /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  end
end
