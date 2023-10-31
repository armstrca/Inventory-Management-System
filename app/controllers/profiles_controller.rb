class ProfilesController < ApplicationController
  # before_action :set_user, only: %i[ show ]

  # devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
    @user = User.find(params[:id])
  end
end
