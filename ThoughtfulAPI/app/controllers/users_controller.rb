class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update]

  swagger_controller :users, "User Management"

  swagger_api :index do
    summary "Fetches all users"
    notes "This lists all the users"
  end

  swagger_api :show do
    summary "Shows one user"
    param :path, :id, :integer, :required, "User ID"
    notes "This lists details of one user"
    response :not_found
  end

  swagger_api :create do
    summary "Creates a new User"
    param :form, :first_name, :string, :required, "First name"
    param :form, :last_name, :string, :required, "Last name"
    param_list :form, :role, :string, :required, "Role", [ :doctor, :patient, :caretaker, :admin ]
    param :form, :family_id, :integer, :required, "Family ID"
    response :not_acceptable
  end

  swagger_api :update do
    summary "Updates an existing User"
    param :path, :id, :integer, :required, "User Id"
    param :form, :first_name, :string, :opitonal, "First name"
    param :form, :last_name, :string, :optional, "Last name"
    param_list :form, :role, :string, :optional, "Role", [ "doctor", "patient", "caretaker", "admin" ]
    param :form, :family_id, :integer, :optional, "Family ID"
    response :not_found
    response :not_acceptable
  end

  swagger_api :destroy do
    summary "Deletes an existing User"
    param :path, :id, :integer, :required, "User Id"
    response :not_found
  end

  # GET /users
  def index
    @users = User.all

    render json: @users
  end


  # GET /users/1
  def show
    render json: @user
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.permit(:first_name, :last_name, :role, :family_id)
    end
end
